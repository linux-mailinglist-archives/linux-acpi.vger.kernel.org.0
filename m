Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDBE911C863
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2019 09:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfLLIp7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 03:45:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54329 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfLLIp7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Dec 2019 03:45:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so1384973wmj.4
        for <linux-acpi@vger.kernel.org>; Thu, 12 Dec 2019 00:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ysjj9kjjoSIsFGYFqXCoqpOZyZtCGjaHakYJs3J9tu0=;
        b=N1PqWi95BtpSJzjsz/imsAalWGW70TyGbewoErGOeVYBvmj9ihXbpRHlxXIvaeIdlR
         nHD/dzoQNgA60wueuAOGCb/L+hXKeY7w9KTGtJUq1VSy6T2dfe1tL7lOYkrcG1ddn4gw
         hOBTY06mszGcg9kdbiouVhtIe1PYsdzXkRvp+rXKt6w0STrNRVaF/lGfCGKAb1pV+Z1Y
         yHpNGXQ3JIoX2JaEcuk5Wp/anUnYiXNSkvJX2qXWnHcutx24QNBY/QFaNHIMyG4LFKSE
         LOOR99KWBWA/Ukr08iOkTK5nE9MvbxjarBOjT/6rEux4i6ppKrzbd2Cynkl7BHjOIzlm
         mdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ysjj9kjjoSIsFGYFqXCoqpOZyZtCGjaHakYJs3J9tu0=;
        b=SYljBDyzofgmdqqnrFsFogIPk3v5V/fSxkPVhm3D1lOPufZ7CMBrp3ca4XUAlH4uEm
         mpRLkFMQ6N772A05AOs4dxzFJX2kfJn4/gJlSNWES0yQZW5IG/21cSCJ1nrGLIRteZPY
         EvwarNJdUArco8Jj9uZ2+tZFeqd33NkVAoisaPzLfFjhVjjhj8KaFjbz6OvIxGUMdn/l
         FzIb7I4O5t0D8luO/rpAYs5TmXCIidgi22M+R96pnwAY86cZd4yli5Vki6v/25tQCCuX
         uJKWeZETy0IrsQ7W2kc0MZGLVjsgo07c/25UyCb6TguCRHeMnu1NocEIzAxuPvu6e70U
         cV1g==
X-Gm-Message-State: APjAAAW4912SbCDmE7pQ6+xAgnY3N5U0hwzlED47t+jZR5fkCdVmoFBu
        /EWXdZFFjbl+UXIUGbWKIYBCuQ==
X-Google-Smtp-Source: APXvYqwAZfpkK8vySmNTpYajooUQMZ/RgbPaVPzY1J92T1Yb1GNzuR3Kfm3il2PW8j/esg6YAvAe+g==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr5235577wmh.81.1576140357340;
        Thu, 12 Dec 2019 00:45:57 -0800 (PST)
Received: from dell ([95.149.164.71])
        by smtp.gmail.com with ESMTPSA id k8sm5263306wrl.3.2019.12.12.00.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 00:45:56 -0800 (PST)
Date:   Thu, 12 Dec 2019 08:45:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mfd: intel_soc_pmic: Rename pwm_backlight pwm-lookup
 to pwm_pmic_backlight
Message-ID: <20191212084546.GA3468@dell>
References: <20191119151818.67531-1-hdegoede@redhat.com>
 <20191119151818.67531-3-hdegoede@redhat.com>
 <20191210085111.GQ3468@dell>
 <a05e5a2b-568e-2b0d-0293-aa937c590a74@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a05e5a2b-568e-2b0d-0293-aa937c590a74@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 11 Dec 2019, Hans de Goede wrote:

> Hi Lee,
> 
> On 10-12-2019 09:51, Lee Jones wrote:
> > On Tue, 19 Nov 2019, Hans de Goede wrote:
> > 
> > > At least Bay Trail (BYT) and Cherry Trail (CHT) devices can use 1 of 2
> > > different PWM controllers for controlling the LCD's backlight brightness.
> > > 
> > > Either the one integrated into the PMIC or the one integrated into the
> > > SoC (the 1st LPSS PWM controller).
> > > 
> > > So far in the LPSS code on BYT we have skipped registering the LPSS PWM
> > > controller "pwm_backlight" lookup entry when a Crystal Cove PMIC is
> > > present, assuming that in this case the PMIC PWM controller will be used.
> > > 
> > > On CHT we have been relying on only 1 of the 2 PWM controllers being
> > > enabled in the DSDT at the same time; and always registered the lookup.
> > > 
> > > So far this has been working, but the correct way to determine which PWM
> > > controller needs to be used is by checking a bit in the VBT table and
> > > recently I've learned about 2 different BYT devices:
> > > Point of View MOBII TAB-P800W
> > > Acer Switch 10 SW5-012
> > > 
> > > Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
> > > PWM controller (and the VBT correctly indicates this), so here our old
> > > heuristics fail.
> > > 
> > > Since only the i915 driver has access to the VBT, this commit renames
> > > the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
> > > controller to "pwm_pmic_backlight" so that the i915 driver can do a
> > > pwm_get() for the right controller depending on the VBT bit, instead of
> > > the i915 driver relying on a "pwm_backlight" lookup getting registered
> > > which magically points to the right controller.
> > > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > >   drivers/mfd/intel_soc_pmic_core.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > For my own reference:
> >    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> As mentioned in the cover-letter, to avoid breaking bi-sectability
> as well as to avoid breaking the intel-gfx CI we need to merge this series
> in one go through one tree. Specifically through the drm-intel tree.
> Is that ok with you ?
> 
> If this is ok with you, then you do not have to do anything, I will just push
> the entire series to drm-intel. drivers/mfd/intel_soc_pmic_core.c
> does not see much changes so I do not expect this to lead to any conflicts.

It's fine, so long as a minimal immutable pull-request is provided.
Whether it's pulled or not will depend on a number of factors, but it
needs to be an option.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
