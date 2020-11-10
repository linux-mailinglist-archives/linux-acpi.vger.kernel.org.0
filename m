Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECD92AD952
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgKJOy7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 09:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgKJOy7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 09:54:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78197C0613CF
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2020 06:54:59 -0800 (PST)
Received: from nazgul.tnic (unknown [78.130.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B92481EC03CE;
        Tue, 10 Nov 2020 15:54:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605020098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W20Fyd8Ip8qokRMTAYo4r0St35mhsnTTy8JB9LOXQgo=;
        b=ScQbdE6xlzpH8SpXPOiX50/7L76W4fTZEj9wXcubaT1p6Je8asIrSXX7jPXE117KtqF+5o
        kEAt5DbcZG/5P5I1g4fr7K3TVrQtkl/SSU0t8jK5yXigk9gN1StDqk3b/VmRDLygEyXrhh
        JQG2Hc+zYJPqMFy5wkWsncjtDZ3vWV0=
Date:   Tue, 10 Nov 2020 15:54:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     yaoaili126@163.com
Cc:     james.morse@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, linux-acpi@vger.kernel.org,
        YANGFENG1@kingsoft.com, yaoaili@kingsoft.com
Subject: Re: [PATCH] ACPI, APEI, Fix incorrect return value of
 apei_map_generic_address
Message-ID: <20201110145450.GA9857@nazgul.tnic>
References: <20201110120002.459078-1-yaoaili126@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110120002.459078-1-yaoaili126@163.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2020 at 04:00:02AM -0800, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
> 
> Hi!
> Thank you for all the suggestions and comments!
> I have re-submited the patch following your comments
> I really need to read Documentation/process more detailly!

Yes, and while doing that please read about top-posting too and stop
doing it.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
