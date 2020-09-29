Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9174227D97B
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 23:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgI2VBW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Sep 2020 17:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728729AbgI2VBW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Sep 2020 17:01:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601413281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OM1lPFLRLnTyz/L53c/yNhrqWz31jPAtm/Ix7oSVMYE=;
        b=LR+cPDfA/FM4zRVX7RfVrMeiKFlLtIH+wUncZrTOZYgF3h41MU/dkdme60+9nlttHHb/pv
        VG6v2HoDmjdMskczNvqq+FNWrOEMnvKKqMpTpMg2ZXAg1svwjLMHcl+yraeSX+h5JxxyuD
        i0+YO/aJhKG7Wuun0OvpIUkFMwFYlRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-Rgi3LXT-NPGWy9QVxiXX6g-1; Tue, 29 Sep 2020 17:01:17 -0400
X-MC-Unique: Rgi3LXT-NPGWy9QVxiXX6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1966801AE4;
        Tue, 29 Sep 2020 21:01:15 +0000 (UTC)
Received: from ovpn-66-32.rdu2.redhat.com (ovpn-66-32.rdu2.redhat.com [10.10.66.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCBEA55796;
        Tue, 29 Sep 2020 21:01:14 +0000 (UTC)
Message-ID: <ea97f1c4c03bd5d227f2aeed18163bf11490812c.camel@redhat.com>
Subject: Re: [PATCH] ACPICA: Fix a soft-lockup on large systems
From:   Qian Cai <cai@redhat.com>
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Date:   Tue, 29 Sep 2020 17:01:14 -0400
In-Reply-To: <MWHPR11MB1599F021CB3EBADF44562D5CF0320@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20200929183444.25079-1-cai@redhat.com>
         <MWHPR11MB1599F021CB3EBADF44562D5CF0320@MWHPR11MB1599.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2020-09-29 at 19:55 +0000, Kaneda, Erik wrote:
> This is acpica code and cond_resched is specific to Linux so we cannot accept
> this in its current form.

Do you have any suggestion?

> 
> The execution time of acpi_ns_walk_namespace is relative to the size of the
> acpi namespace. This is determined by the size of firmware..
> If the actual culprit was the traversing the ACPI namespace, you should have a
> soft lock up on acpi_load_tables which is the function that populates the ACPI
> namespace. Your stack trace shows that Linux was able to get past this point.
> Therefore, I'm led to think that the actual problem is the combination of
> walking the namespace + the handler invoked.
> 
> What happens if you add the cond_resched in acpi_bus_check_add?

This also works fine.

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1881,6 +1881,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle,
u32 lvl_not_used,
                return AE_OK;
        }
 
+       cond_resched();
        acpi_add_single_object(&device, handle, type, sta);
        if (!device)
                return AE_CTRL_DEPTH;

> 
> Out of curiosity, does calling cond_resched guarantee that the acpi_init call
> will finish before other kernel components that depend on ACPI are
> initialized?

I don't really see how it could break the dependencies. cond_resched() is just
to avoid stalling the CPU.

