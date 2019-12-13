Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED811DF69
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 09:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfLMI1s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 03:27:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52894 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfLMI1r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Dec 2019 03:27:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so5329777wmc.2
        for <linux-acpi@vger.kernel.org>; Fri, 13 Dec 2019 00:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JwuoHfqD4FyIs4KF1Ipmu8G5TBEwPS2a5x2rk/31xck=;
        b=RZu/Wv0m4HqQgb7kZHHwyZiV72yCDHClDTjqRYig6G327C22KOVE23Gl4QlWIk4J9g
         /mTwG/EcWHHf9sYXXpPtTpllj8NvhWZ9k5SsV4jgWzE2uqeHWssPggXoaT2gjyI8wre+
         VqxL2RAU5YTssHRWil1Gz4l8a8O18PLMhlz0Fd0EfGvTrga/wRtXo8/VzsNwEzcaJc2o
         kCgWLQL7844S7BROBTksqLxNyH5Y12iS0O9bHQi+v4QV3BqAKqGVjvm8V1yufjNHj3vI
         SyFI8XHa40wO7C8ZTiULcUMVsX8duH9Oq530Z+8L5UrJXOxugLt6sFTO3yrlOsl2a4f/
         pvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JwuoHfqD4FyIs4KF1Ipmu8G5TBEwPS2a5x2rk/31xck=;
        b=tOGnDS28LVEgX6JMD+b+R0o05YWwFSoYV5s4z7vp1EKYZr798E750di9joVKTul8IC
         ZWH3JuKlRAGkEqfQ5Q+vMs1EoDQzz9DM1BIQKpudRNAGU8XBa0mZWBdrkzhLvJxqPWhG
         3nmtgixuHH4t9HaKUPz39P5HYQjZqLothif6ombhx8X0zh4tqdJCcEcaiFLM997zVhmd
         gQ0Jz+mD/d/zFkzHI0M/P6XdRRmeZDl7CCocE5olE8sMU5pGst+BMkAdnz/ReU/yZWJo
         y7eu4ZW+ehovY7xlOMpUXrLGRV+5MNO5kPTH53N+yoU0AbNlyx2PLaAuQH/YAMRBnAF6
         pAZQ==
X-Gm-Message-State: APjAAAVErDFKEUk1OteyQmNvReXsfzpwwNjDMyQgvYnks/FFOhwrbWj5
        htqwio1N3WXnsKL1E2rt5oeofw==
X-Google-Smtp-Source: APXvYqw9NFR6SJCU7qpurkLNw/ZkJfL008Kue/7hzmCvNYuR/i+XEHjDwK63wFSkZZdj2Cmg0QgOSw==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr12505169wme.125.1576225664505;
        Fri, 13 Dec 2019 00:27:44 -0800 (PST)
Received: from dell ([95.149.164.71])
        by smtp.gmail.com with ESMTPSA id a133sm225770wme.29.2019.12.13.00.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 00:27:43 -0800 (PST)
Date:   Fri, 13 Dec 2019 08:27:34 +0000
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
Message-ID: <20191213082734.GE3468@dell>
References: <20191119151818.67531-1-hdegoede@redhat.com>
 <20191119151818.67531-3-hdegoede@redhat.com>
 <20191210085111.GQ3468@dell>
 <a05e5a2b-568e-2b0d-0293-aa937c590a74@redhat.com>
 <20191212084546.GA3468@dell>
 <d22e9a04-da09-0f41-a78e-ac17a947650a@redhat.com>
 <20191212155209.GC3468@dell>
 <4d07445d-98b1-f23c-0aac-07709b45df78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d07445d-98b1-f23c-0aac-07709b45df78@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 12 Dec 2019, Hans de Goede wrote:

> Hi,
> 
> On 12-12-2019 16:52, Lee Jones wrote:
> > On Thu, 12 Dec 2019, Hans de Goede wrote:
> > 
> > > Hi,
> > > 
> > > On 12-12-2019 09:45, Lee Jones wrote:
> > > > On Wed, 11 Dec 2019, Hans de Goede wrote:
> > > > 
> > > > > Hi Lee,
> > > > > 
> > > > > On 10-12-2019 09:51, Lee Jones wrote:
> > > > > > On Tue, 19 Nov 2019, Hans de Goede wrote:
> > > > > > 
> > > > > > > At least Bay Trail (BYT) and Cherry Trail (CHT) devices can use 1 of 2
> > > > > > > different PWM controllers for controlling the LCD's backlight brightness.
> > > > > > > 
> > > > > > > Either the one integrated into the PMIC or the one integrated into the
> > > > > > > SoC (the 1st LPSS PWM controller).
> > > > > > > 
> > > > > > > So far in the LPSS code on BYT we have skipped registering the LPSS PWM
> > > > > > > controller "pwm_backlight" lookup entry when a Crystal Cove PMIC is
> > > > > > > present, assuming that in this case the PMIC PWM controller will be used.
> > > > > > > 
> > > > > > > On CHT we have been relying on only 1 of the 2 PWM controllers being
> > > > > > > enabled in the DSDT at the same time; and always registered the lookup.
> > > > > > > 
> > > > > > > So far this has been working, but the correct way to determine which PWM
> > > > > > > controller needs to be used is by checking a bit in the VBT table and
> > > > > > > recently I've learned about 2 different BYT devices:
> > > > > > > Point of View MOBII TAB-P800W
> > > > > > > Acer Switch 10 SW5-012
> > > > > > > 
> > > > > > > Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
> > > > > > > PWM controller (and the VBT correctly indicates this), so here our old
> > > > > > > heuristics fail.
> > > > > > > 
> > > > > > > Since only the i915 driver has access to the VBT, this commit renames
> > > > > > > the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
> > > > > > > controller to "pwm_pmic_backlight" so that the i915 driver can do a
> > > > > > > pwm_get() for the right controller depending on the VBT bit, instead of
> > > > > > > the i915 driver relying on a "pwm_backlight" lookup getting registered
> > > > > > > which magically points to the right controller.
> > > > > > > 
> > > > > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > > > > ---
> > > > > > >     drivers/mfd/intel_soc_pmic_core.c | 2 +-
> > > > > > >     1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > For my own reference:
> > > > > >      Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > 
> > > > > As mentioned in the cover-letter, to avoid breaking bi-sectability
> > > > > as well as to avoid breaking the intel-gfx CI we need to merge this series
> > > > > in one go through one tree. Specifically through the drm-intel tree.
> > > > > Is that ok with you ?
> > > > > 
> > > > > If this is ok with you, then you do not have to do anything, I will just push
> > > > > the entire series to drm-intel. drivers/mfd/intel_soc_pmic_core.c
> > > > > does not see much changes so I do not expect this to lead to any conflicts.
> > > > 
> > > > It's fine, so long as a minimal immutable pull-request is provided.
> > > > Whether it's pulled or not will depend on a number of factors, but it
> > > > needs to be an option.
> > > 
> > > The way the drm subsys works that is not really a readily available
> > > option. The struct definition which this patch changes a single line in
> > > has not been touched since 2015-06-26 so I really doubt we will get a
> > > conflict from this.
> > 
> > Always with the exceptions ...
> > 
> > OOI, why does this *have* to go through the DRM tree?
> 
> This patch renames the name used to lookup the pwm controller from
> "pwm_backlight" to "pwm_pmic_backlight" because there are 2 possible
> pwm controllers which may be used, one in the SoC itself and one
> in the PMIC. Which controller should be used is described in a table
> in the Video BIOS, so another part of this series adds this code to
> the i915 driver:
> 
> -	panel->backlight.pwm = pwm_get(dev->dev, "pwm_backlight");
> +	/* Get the right PWM chip for DSI backlight according to VBT */
> +	if (dev_priv->vbt.dsi.config->pwm_blc == PPS_BLC_PMIC) {
> +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_pmic_backlight");
> +		desc = "PMIC";
> +	} else {
> +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_soc_backlight");
> +		desc = "SoC";
> +	}
> 
> So both not to break bisectability, but also so as to not break the extensive
> CI system which is used to test the i915 driver we need the MFD change doing
> the rename to go upstrream through the same tree as the i915 change.
> 
> I have even considered just squashing the 2 commits together as having only 1
> present, but not the other breaks stuff left and right.

That doesn't answer the question.

Why do they all *have* to go in via the DRM tree specifically?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
