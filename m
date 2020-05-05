Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE581C56A0
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 15:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgEENVn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 May 2020 09:21:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23325 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728898AbgEENVm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2020 09:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588684902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cJjk1voas+0dvk9PcOEDjKeOiN5/Y1FC1G41w1fjgkU=;
        b=PeUzvSoRFiiIdPskcW/C6b0ad7gE9pXBa6+iPw4pwhR3khn/2jS/CWW/h/7/f080SZDRMo
        7YPBm50/O3Aucixwl0eu40DxykW59LLb3D8fmUpxR2v9nstBfe2XqXn21LnpuxbJ0fHDnR
        8gfBM/vf0LNRfJcW7tEA8wVsjyjpHKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-ldwf50YtMyquTXqrm3sR9g-1; Tue, 05 May 2020 09:21:40 -0400
X-MC-Unique: ldwf50YtMyquTXqrm3sR9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BD1010CE784;
        Tue,  5 May 2020 13:21:38 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-21.ams2.redhat.com [10.36.113.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A748D6060E;
        Tue,  5 May 2020 13:21:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 0/3] ACPI / utils: Add acpi_evaluate_reg() helper
Date:   Tue,  5 May 2020 15:21:25 +0200
Message-Id: <20200505132128.19476-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Here is a small series adding an acpi_evaluate_reg() helper, note
the third patch sits on top of a fix for the pinctrl-cherryview
driver which I recently submitted and which is still finding its
way upstream.

Since this is not urgent (just a small code cleanup) I suggest
that the ACPI people can pick up patches 1-2 and then the last patch
can be merged post 5.8-rc1, at which point all the dependencies for
it should have landed already.

Regards,

Hans

