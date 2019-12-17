Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15AE122655
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 09:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfLQILc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 03:11:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36378 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfLQILb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2019 03:11:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so2689664wru.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Dec 2019 00:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=19dNxyewZB4bW5EpbtiZDPOC9w8YFBemE/6BfNexMJ0=;
        b=VJSF7QL+BcPWBFi5TTVf4GyWri6KWZKSJ0pcqDeRFj+QPYczAvOVz7S693VcdasDGx
         tc8bjYleSN+8Bl5XBywxzbrV27JkQHbuv5ayw/jbK2qxK+1o3p52RTdpG7x5rM08UFsh
         mtcIxOmnbfEmL48XL7/azzvRVlcwX7GSVx1EGUzlAUeTylIeZpUj/VZ7Ywrf4wR0ORwW
         uU2Av/njCfZ644n7dyAytFVJmNj+EuLBGgcvkV2s0La8frLSm0ze3ra9mLzWTdeCbsli
         Ce9aOcNzsprDNZswFtdu/qi+SqeWrQxMymod02lhGseic4Iah4SpHAIu4eLY4Yibei8q
         80iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=19dNxyewZB4bW5EpbtiZDPOC9w8YFBemE/6BfNexMJ0=;
        b=T0gJyKaORnDRY95Zm2W7yDEy4dVutuWCdSDwjQYwtLoALKy2vI0/hZTwP5p+z4Jh3a
         xJJ+6iVIAMQqhwaK1gzjNfjnWlodbAxFD1QqXmFMSo8Zke40liOcvSKIC73pp9Tpvuml
         6SYEHXUyGd8rAoB5lQLCpevh3Q9JKxUVYFXPkfE6ab04r2kYbLSDOPvKtrT6y2DTsCM0
         rzqNG/c02LYpdQQtduaC1u2zcKBEBoT0bjEl6lEetoil9pXo+VoMOeFdAbE51VfDPjAF
         dHq6tdDvsJzRAPXGAK5FDKLHbynAntUksl4dIneZn5NS1EG4Ns0ADgZG2Lp5sHxNLfFx
         USvA==
X-Gm-Message-State: APjAAAX0u723mnwSARoP6VP5zzXCpLohPraQ2tBU88CG0xGAvHnZkY4B
        GiCGyWEbuV24i6yqhUC7Vk1aEQ==
X-Google-Smtp-Source: APXvYqwsEgFgq+4gwcQu8MwsxsRlS9smqiXdgF8o6OW6OU+GyBfno1a/1gxtpoebGTfkhJmcAFDCkg==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr35810316wru.296.1576570288028;
        Tue, 17 Dec 2019 00:11:28 -0800 (PST)
Received: from dell (h185-20-99-142.host.redstation.co.uk. [185.20.99.142])
        by smtp.gmail.com with ESMTPSA id n16sm24673119wro.88.2019.12.17.00.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 00:11:27 -0800 (PST)
Date:   Tue, 17 Dec 2019 08:11:27 +0000
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
Message-ID: <20191217081127.GI18955@dell>
References: <20191210085111.GQ3468@dell>
 <a05e5a2b-568e-2b0d-0293-aa937c590a74@redhat.com>
 <20191212084546.GA3468@dell>
 <d22e9a04-da09-0f41-a78e-ac17a947650a@redhat.com>
 <20191212155209.GC3468@dell>
 <4d07445d-98b1-f23c-0aac-07709b45df78@redhat.com>
 <20191213082734.GE3468@dell>
 <d648794d-4c76-cfa1-dcbd-16c34d409c51@redhat.com>
 <20191216093016.GE3648@dell>
 <fc3c29da-528d-a6b6-d13b-92e6469eadea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc3c29da-528d-a6b6-d13b-92e6469eadea@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 16 Dec 2019, Hans de Goede wrote:

> Hi,
> 
> On 16-12-2019 10:30, Lee Jones wrote:
> > [...]
> > 
> > > > > > > > > > > Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
> > > > > > > > > > > PWM controller (and the VBT correctly indicates this), so here our old
> > > > > > > > > > > heuristics fail.
> > > > > > > > > > > 
> > > > > > > > > > > Since only the i915 driver has access to the VBT, this commit renames
> > > > > > > > > > > the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
> > > > > > > > > > > controller to "pwm_pmic_backlight" so that the i915 driver can do a
> > > > > > > > > > > pwm_get() for the right controller depending on the VBT bit, instead of
> > > > > > > > > > > the i915 driver relying on a "pwm_backlight" lookup getting registered
> > > > > > > > > > > which magically points to the right controller.
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > > > > > > > > ---
> > > > > > > > > > >       drivers/mfd/intel_soc_pmic_core.c | 2 +-
> > > > > > > > > > >       1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > > 
> > > > > > > > > > For my own reference:
> > > > > > > > > >        Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > > > 
> > > > > > > > > As mentioned in the cover-letter, to avoid breaking bi-sectability
> > > > > > > > > as well as to avoid breaking the intel-gfx CI we need to merge this series
> > > > > > > > > in one go through one tree. Specifically through the drm-intel tree.
> > > > > > > > > Is that ok with you ?
> > > > > > > > > 
> > > > > > > > > If this is ok with you, then you do not have to do anything, I will just push
> > > > > > > > > the entire series to drm-intel. drivers/mfd/intel_soc_pmic_core.c
> > > > > > > > > does not see much changes so I do not expect this to lead to any conflicts.
> > > > > > > > 
> > > > > > > > It's fine, so long as a minimal immutable pull-request is provided.
> > > > > > > > Whether it's pulled or not will depend on a number of factors, but it
> > > > > > > > needs to be an option.
> > > > > > > 
> > > > > > > The way the drm subsys works that is not really a readily available
> > > > > > > option. The struct definition which this patch changes a single line in
> > > > > > > has not been touched since 2015-06-26 so I really doubt we will get a
> > > > > > > conflict from this.
> > > > > > 
> > > > > > Always with the exceptions ...
> > > > > > 
> > > > > > OOI, why does this *have* to go through the DRM tree?
> > > > > 
> > > > > This patch renames the name used to lookup the pwm controller from
> > > > > "pwm_backlight" to "pwm_pmic_backlight" because there are 2 possible
> > > > > pwm controllers which may be used, one in the SoC itself and one
> > > > > in the PMIC. Which controller should be used is described in a table
> > > > > in the Video BIOS, so another part of this series adds this code to
> > > > > the i915 driver:
> > > > > 
> > > > > -	panel->backlight.pwm = pwm_get(dev->dev, "pwm_backlight");
> > > > > +	/* Get the right PWM chip for DSI backlight according to VBT */
> > > > > +	if (dev_priv->vbt.dsi.config->pwm_blc == PPS_BLC_PMIC) {
> > > > > +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_pmic_backlight");
> > > > > +		desc = "PMIC";
> > > > > +	} else {
> > > > > +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_soc_backlight");
> > > > > +		desc = "SoC";
> > > > > +	}
> > > > > 
> > > > > So both not to break bisectability, but also so as to not break the extensive
> > > > > CI system which is used to test the i915 driver we need the MFD change doing
> > > > > the rename to go upstrream through the same tree as the i915 change.
> > > > > 
> > > > > I have even considered just squashing the 2 commits together as having only 1
> > > > > present, but not the other breaks stuff left and right.
> > > > 
> > > > That doesn't answer the question.
> > > > 
> > > > Why do they all *have* to go in via the DRM tree specifically?
> > > 
> > > 1. As explained these chanegs need to stay together
> > > 2. This change is primarily a drm/i915 change. Also the i915 code sees lots
> > > of changes every cycle, where as the change to the mfd code touches a block
> > > of code which has not been touched since 2015-06-26, so the chance of conflicts
> > > is much bigger if this goes on through another tree.
> > > 
> > > I honestly do not see the problem here? Let me reverse the question why should this
> > > NOT go in through the drm tree?
> > 
> > There isn't a problem with *this* patch.  I could say, "sure, take it"
> > and the chances are everything could be fine from a technical
> > perspective.
> > 
> > However, I'm taking exception to the fact you think this series is
> > *special* enough to warrant circumventing the usual way in which we
> > usually work when dealing with cross-subsystem patch-sets.  Something
> > I personally deal with a lot due to the inherent hierarchical nature
> > of Multi-Functional Devices.
> > 
> > I'm on the fence on this one.  Due to the circumstances surrounding
> > *this* patch alone, it would be so much easier (for both of us!) to
> > just Ack the patch and hope no further changes occur which could
> > potentially cause someone else (you, me, Linus) more work later on.
> > However, I'm very keen to prevent setting a precedent for this kind of
> > action, as it's clearly not the right path to take in a vast majority
> > of cases.
> > 
> > > 1. As explained these chanegs need to stay together
> > 
> > The patch-set would stay together regardless.  That's the point of an
> > immutable branch, it can be taken in by all relevant parties and Git
> > will just do-the-right-thing.
> > 
> > > 2. This change is primarily a drm/i915 change. Also the i915 code sees lots
> > > of changes every cycle, where as the change to the mfd code touches a block
> > > of code which has not been touched since 2015-06-26, so the chance of conflicts
> > > is much bigger if this goes on through another tree.
> > 
> > This too is irrelevant, since the patch-set could/would go though
> > both/all trees simultaneously.  The way in which we normally work with
> > other subsystems doesn't involve a gamble over which subsystem is most
> > likely going to be affected by a merge conflict as you suggest, it
> > eradicates conflicts for all.
> 
> I'm well aware of using immutable branches and that those are
> often used for patch-set's which touch multiple subsystems. But
> although immutable branches are used often they are about as often
> not used for various reasons, with people choosing to just merge
> through a single tree.
> > I'm not saying "no" by the way.  I just want to find out your
> > reasons/motivation as to why you're insisting this needs go through
> > a) a specific tree and b) just one tree.  Questions which I am yet to
> > see a compelling answer.
> 
> Doing immutable branches assumes that there is a base point,
> e.g. 5.5-rc1 where the immutable branch can then be based on and
> that the branch can then be merged without issues into both subsystems.
> 
> drm is constantly evolving to deal with and mostly catch up with new
> hardware as both GPUs and display-pipelines are evolving quite rapidly
> atm drm-intel-next has about 400 commits on top of 5.5-rc1 so for an
> immutable branch I can either base it on drm-intel-next which
> violates your request for a clean minimal branch to merge; or I can
> base it on 5.5-rc1 which leads to a big chance of problems when
> merging it given to large amount of churn in drm-intel-next.

This is a *slightly* more compelling reason than the ones you've
previously provided.

> So instead of the normal case of 2 subsystems seeing some changes
> on both side the case we have here is a part of a file which has
> not changed since 2015-06-26 in one subsys (and changing only
> a single line there!) and OTOH we have bigger changes to a subsys
> which see 400 patches land in the first week since rc1 .

This is not.

> I hope that you agree that in this case given the large amount of
> churn in drm-intel-next it makes since to just straight forward
> apply these patches on top of drm-intel-next.

I have Acked this patch, but remember *this* is the exception rather
than the rule.  If/when we have a case where a contributor works
cross-subsystem with DRM and the code/file adapted is live (more
likely to change), I will have to insist on an immutable branch
strategy.  DRM will have to deal with that appropriately.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
