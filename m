Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72577120130
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 10:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLPJaZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 04:30:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52174 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLPJaZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 04:30:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id d73so5931228wmd.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2019 01:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2fv+cy54Z2gjOjTkGdo5fHeBJ2YDFHHPTya4tHB3UIs=;
        b=BGz3qk5l1P8rNbvuIn9c75pP4YR9nxmPVoZ4TFSeZWTWQ+3P81xlCDV29Vi5Tct61t
         pQjsOWusZNpcmvAdmu2XY85KkQn11WCxuTLCl6VIvjXlgQTm8GVVhoH7qTo+BpRnEcC0
         iW/lgoQ+Jn9FxZRZkPJxwDSO1LXYdCXqliYIh9T7frgcGF/nQWugnwqVlbc7IeQpZ49O
         t/Pn8Bf+zAWIv1S6J/5IxlIfNj6JSrHuOTUKGfivd77Fz0+sypCoNqb88kAz3o9C+i22
         WaPZwfQUG471SkauNLx/o+pLCpLLupgfYxqXipvqtbTjRbXZCP/kY2fZYh7fEYra+Qts
         YS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2fv+cy54Z2gjOjTkGdo5fHeBJ2YDFHHPTya4tHB3UIs=;
        b=S0ByqIe1/OMCjaoteLBHGP+x9cjLaRKZEi5CaSq+q6at4NS4aEwAroYxGRe21FAV3E
         7AnTdGFiuy+Woyp5ulmP1ITjxNovjQidmKD14ZalvHizTqUfOcVSKREKWTCeHFUW3YGq
         BhFKzoDshLUjUGM2TvfgeK1QVcsaAQDudLYB4xw1anufsr4vPGdbJpe8pfRbN38JXObJ
         vml2jGp5QE/xeDeQSWeoWUYFDsn7ctwkt2ZEt4XeA4VCVnPNRcGZJcFziYDOLOzUFaEN
         mmBC11O1fNKzwOivt8rvPWreaMhTZ+DmZgpHBuO8LTXFPvII9lfXb6gKtbJA7m9zd8WG
         MQKg==
X-Gm-Message-State: APjAAAXr67JhcHiUvUAJP/Xe2IDMIKxBtKIe9NOxsJy38acfkr8/eF0g
        85j4xzRIehR2WgmoH6LmgxBU8ab6fIE=
X-Google-Smtp-Source: APXvYqwC9HRTbjxHB3QHoWl0Xg68Z+CY+ThtuauwuGZUc7gJP/hJ6Wv4prK2y5dv7VLMtk/x5RTIpQ==
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr20727023wme.148.1576488622154;
        Mon, 16 Dec 2019 01:30:22 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id m10sm21098892wrx.19.2019.12.16.01.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 01:30:21 -0800 (PST)
Date:   Mon, 16 Dec 2019 09:30:16 +0000
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
Message-ID: <20191216093016.GE3648@dell>
References: <20191119151818.67531-1-hdegoede@redhat.com>
 <20191119151818.67531-3-hdegoede@redhat.com>
 <20191210085111.GQ3468@dell>
 <a05e5a2b-568e-2b0d-0293-aa937c590a74@redhat.com>
 <20191212084546.GA3468@dell>
 <d22e9a04-da09-0f41-a78e-ac17a947650a@redhat.com>
 <20191212155209.GC3468@dell>
 <4d07445d-98b1-f23c-0aac-07709b45df78@redhat.com>
 <20191213082734.GE3468@dell>
 <d648794d-4c76-cfa1-dcbd-16c34d409c51@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d648794d-4c76-cfa1-dcbd-16c34d409c51@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[...]

> > > > > > > > > Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
> > > > > > > > > PWM controller (and the VBT correctly indicates this), so here our old
> > > > > > > > > heuristics fail.
> > > > > > > > > 
> > > > > > > > > Since only the i915 driver has access to the VBT, this commit renames
> > > > > > > > > the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
> > > > > > > > > controller to "pwm_pmic_backlight" so that the i915 driver can do a
> > > > > > > > > pwm_get() for the right controller depending on the VBT bit, instead of
> > > > > > > > > the i915 driver relying on a "pwm_backlight" lookup getting registered
> > > > > > > > > which magically points to the right controller.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > > > > > > ---
> > > > > > > > >      drivers/mfd/intel_soc_pmic_core.c | 2 +-
> > > > > > > > >      1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > For my own reference:
> > > > > > > >       Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > 
> > > > > > > As mentioned in the cover-letter, to avoid breaking bi-sectability
> > > > > > > as well as to avoid breaking the intel-gfx CI we need to merge this series
> > > > > > > in one go through one tree. Specifically through the drm-intel tree.
> > > > > > > Is that ok with you ?
> > > > > > > 
> > > > > > > If this is ok with you, then you do not have to do anything, I will just push
> > > > > > > the entire series to drm-intel. drivers/mfd/intel_soc_pmic_core.c
> > > > > > > does not see much changes so I do not expect this to lead to any conflicts.
> > > > > > 
> > > > > > It's fine, so long as a minimal immutable pull-request is provided.
> > > > > > Whether it's pulled or not will depend on a number of factors, but it
> > > > > > needs to be an option.
> > > > > 
> > > > > The way the drm subsys works that is not really a readily available
> > > > > option. The struct definition which this patch changes a single line in
> > > > > has not been touched since 2015-06-26 so I really doubt we will get a
> > > > > conflict from this.
> > > > 
> > > > Always with the exceptions ...
> > > > 
> > > > OOI, why does this *have* to go through the DRM tree?
> > > 
> > > This patch renames the name used to lookup the pwm controller from
> > > "pwm_backlight" to "pwm_pmic_backlight" because there are 2 possible
> > > pwm controllers which may be used, one in the SoC itself and one
> > > in the PMIC. Which controller should be used is described in a table
> > > in the Video BIOS, so another part of this series adds this code to
> > > the i915 driver:
> > > 
> > > -	panel->backlight.pwm = pwm_get(dev->dev, "pwm_backlight");
> > > +	/* Get the right PWM chip for DSI backlight according to VBT */
> > > +	if (dev_priv->vbt.dsi.config->pwm_blc == PPS_BLC_PMIC) {
> > > +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_pmic_backlight");
> > > +		desc = "PMIC";
> > > +	} else {
> > > +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_soc_backlight");
> > > +		desc = "SoC";
> > > +	}
> > > 
> > > So both not to break bisectability, but also so as to not break the extensive
> > > CI system which is used to test the i915 driver we need the MFD change doing
> > > the rename to go upstrream through the same tree as the i915 change.
> > > 
> > > I have even considered just squashing the 2 commits together as having only 1
> > > present, but not the other breaks stuff left and right.
> > 
> > That doesn't answer the question.
> > 
> > Why do they all *have* to go in via the DRM tree specifically?
> 
> 1. As explained these chanegs need to stay together
> 2. This change is primarily a drm/i915 change. Also the i915 code sees lots
> of changes every cycle, where as the change to the mfd code touches a block
> of code which has not been touched since 2015-06-26, so the chance of conflicts
> is much bigger if this goes on through another tree.
> 
> I honestly do not see the problem here? Let me reverse the question why should this
> NOT go in through the drm tree?

There isn't a problem with *this* patch.  I could say, "sure, take it"
and the chances are everything could be fine from a technical
perspective.

However, I'm taking exception to the fact you think this series is
*special* enough to warrant circumventing the usual way in which we
usually work when dealing with cross-subsystem patch-sets.  Something
I personally deal with a lot due to the inherent hierarchical nature
of Multi-Functional Devices.

I'm on the fence on this one.  Due to the circumstances surrounding
*this* patch alone, it would be so much easier (for both of us!) to
just Ack the patch and hope no further changes occur which could
potentially cause someone else (you, me, Linus) more work later on.
However, I'm very keen to prevent setting a precedent for this kind of
action, as it's clearly not the right path to take in a vast majority
of cases.

> 1. As explained these chanegs need to stay together

The patch-set would stay together regardless.  That's the point of an
immutable branch, it can be taken in by all relevant parties and Git
will just do-the-right-thing.

> 2. This change is primarily a drm/i915 change. Also the i915 code sees lots
> of changes every cycle, where as the change to the mfd code touches a block
> of code which has not been touched since 2015-06-26, so the chance of conflicts
> is much bigger if this goes on through another tree.

This too is irrelevant, since the patch-set could/would go though
both/all trees simultaneously.  The way in which we normally work with
other subsystems doesn't involve a gamble over which subsystem is most
likely going to be affected by a merge conflict as you suggest, it
eradicates conflicts for all.

I'm not saying "no" by the way.  I just want to find out your
reasons/motivation as to why you're insisting this needs go through
a) a specific tree and b) just one tree.  Questions which I am yet to
see a compelling answer.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
