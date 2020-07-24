Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24F122CB69
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 18:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgGXQrm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jul 2020 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgGXQrm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2020 12:47:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ED1C0619D3;
        Fri, 24 Jul 2020 09:47:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i26so4173755edv.4;
        Fri, 24 Jul 2020 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzDKwcg9p8gnVKAmDaaJM93RupDzTADuoLrwrIiJ8S4=;
        b=bPgwX0Xlb6utFBvmWrYYwjprckvrVERzxB/WKnvCXwUUhJ8YFDnVd6d9kC6FcO+9NP
         17po36U4aKHtFDQfFNtOVk+FaL81aZocyB3PKtmxwZNEYufKoc6xw48d1uQur6wd9wg2
         AbYQTzsIlDdjzKmY1DonVOijtFz9XdE8eL8k5U97zvNky+hFRXG3XkQvaehXjxdTSbLw
         u9vth+lr2Tl4gKpWRH1oue84tZjYGa0x52nwGE9/lhe7J1l8eS04p0/gIv2BEXhtTxSe
         kC7b+ahKrFRSp0uVgaRvSXPiRgMZk4QsjuL1Mx7Da+aAkaKz2VO6UwUHEEBnPH/zg1th
         qrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzDKwcg9p8gnVKAmDaaJM93RupDzTADuoLrwrIiJ8S4=;
        b=rFBhEOpwSDUoeNFRCVjjDWHO4h/IjjKEMa0q1F2w9+AaI7NDzQhEsRbXntaWEyDf40
         AqEEP1y2LIlYoKEjufcsg1Puaty51dB/0izoNOee2OBZb2V+rIpFpXOfT3qrGqs6FdzO
         ePhzSa2Pp7Nuu6976mQ3zTQH0vjeDHTzIIQy2EvgZZuksGGh/ExAfnaAa8DOsLQSFyTP
         GDh02tWqPZY/UVhd5ftBnlGz+J7aCvDA7c8m1BRX2shuKeqz2ceD0fbU2om5HtnJ/1Fw
         SwhkOaZIUgpQQDqpqcm7WKaXgFkacsVXU7h20RcUOigBxL7AMPo2g36PQy7FiL+T0JH2
         OGLw==
X-Gm-Message-State: AOAM530QZfxWXlkBkJkftm4JPiSxccGs0xmGIQT40yYe3Pky0/buKisg
        G7f7rsgS1gZTAAYj+rBnngY=
X-Google-Smtp-Source: ABdhPJw5uXA1NchHuOQ0mFITGNMD2Vb66pBvlCEfZz3Q6x+IfZbiNwlhpyFK18GzcKkCaNx3ZUPaUw==
X-Received: by 2002:aa7:d989:: with SMTP id u9mr9684898eds.85.1595609260520;
        Fri, 24 Jul 2020 09:47:40 -0700 (PDT)
Received: from garrit-VirtualBox ([94.31.102.44])
        by smtp.gmail.com with ESMTPSA id u19sm1112193edd.62.2020.07.24.09.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 09:47:40 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:47:38 +0200
From:   Garrit Franke <garritfranke@gmail.com>
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] trivial: acpi: replace some bitshifts with BIT macro
Message-Id: <20200724184738.ce10d8db0bbe138e2b24f7a6@gmail.com>
In-Reply-To: <BYAPR11MB325604ACC5F3BCCEB89A58AA87770@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <alpine.DEB.2.21.2007241814450.2834@hadrien>
        <20200724162050.18077-2-garritfranke@gmail.com>
        <BYAPR11MB325604ACC5F3BCCEB89A58AA87770@BYAPR11MB3256.namprd11.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 24 Jul 2020 16:29:14 +0000
"Moore, Robert" <robert.moore@intel.com> wrote:

> Where is "BIT" defined?

It is defined in multiple places (see include/vdso/bits.h for example),
therefore I blatently assumed that it would be defined. I'm quite new
to kernel development, and I'm learning along the way. Thank you for
pointing this out.

Would it make sense to copy this file to this drivers root, or is it
not worth the effort?

Thanks for your time
Garrit
