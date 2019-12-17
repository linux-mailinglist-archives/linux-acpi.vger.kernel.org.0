Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFED6122D72
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 14:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfLQNvn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 08:51:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38696 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfLQNvm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2019 08:51:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so11384304wrh.5
        for <linux-acpi@vger.kernel.org>; Tue, 17 Dec 2019 05:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UpDwTP6xUYOJn/p4VO1T9tIwMyJ+3s44ALkmuaBYU3U=;
        b=guHBR27yvZI1WGUgGNV0FTbLksEs26VjD6okj2KrEUZ7Ia9/PrXNaZQYES9kx2u57m
         oVvQTfRwGfahNrqlqQBPDj+2O2vZZNokYrE/qiQnQkopHSabr32d+bsO5z+DnsUOdIxI
         hIGI4d4ordTo242Ptbjn4jXZv42nuGRgWDqBW1Dl4/AerEzcjhNjT01J78z299Lq3xz8
         3W+IguJOnYqVJpr8AFwmLUoh22IRK2t6d2f5eBSCw33X9fQFT2oi44TUaaNtoMkfE18H
         itAbZTJ38FVK5VxN7K+nXcf1UH6RI2VMB7XSMWy/HDHJRC/wMzvzy6qPjYwn290DwdaS
         Rciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UpDwTP6xUYOJn/p4VO1T9tIwMyJ+3s44ALkmuaBYU3U=;
        b=hphwklRGtB3+PISSpW5NCYIYhj7W5XPvdrx1ooodOIoWRNG8OMfcq2jjiew3AShbkx
         eNRU3uyRhyHyOiY0u/HNKHeEY1xqqf700suxwLeT795QVLBFwZizM+fIAWYsqnyeNAHk
         rSzlzUkcSeQSihYsFctDkI7bWFKY0Lxxj9mGN5UAct2CVZ6EvI/ylNiqpIwrmBk0SVTj
         ttIX3FQKIu87+s9Qy6FASBG2KPvu6POXYL/rg72qFbxuu6ku7svwRMWc3OjKYAsckv81
         j6i08PQENfZEJscIwR8rhQd40xzunZiDhVDF7Tt9Hdx4hJ+d3y4SuGOb8ABM/AwvfXQe
         CTcA==
X-Gm-Message-State: APjAAAXAfj1IOfFCkJp/c0wRuakfBzu+N5at/W+27ibztY3gU5K38/IN
        30PjhCgZnPwd8YihZLZoT3pvaQ==
X-Google-Smtp-Source: APXvYqzWqTHQ/8Hj1jyKQHKlahN+h3FSMhKarcDhsgeUhMP0afvTz0/tlTOqBvWUYAzzGTWaWT4WIg==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr39105103wrx.304.1576590700711;
        Tue, 17 Dec 2019 05:51:40 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id n189sm3191999wme.33.2019.12.17.05.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 05:51:40 -0800 (PST)
Date:   Tue, 17 Dec 2019 13:51:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Message-ID: <20191217135140.GL18955@dell>
References: <20191212084546.GA3468@dell>
 <d22e9a04-da09-0f41-a78e-ac17a947650a@redhat.com>
 <20191212155209.GC3468@dell>
 <4d07445d-98b1-f23c-0aac-07709b45df78@redhat.com>
 <20191213082734.GE3468@dell>
 <d648794d-4c76-cfa1-dcbd-16c34d409c51@redhat.com>
 <20191216093016.GE3648@dell>
 <fc3c29da-528d-a6b6-d13b-92e6469eadea@redhat.com>
 <20191217081127.GI18955@dell>
 <87immfyth2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87immfyth2.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 17 Dec 2019, Jani Nikula wrote:

> On Tue, 17 Dec 2019, Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 16 Dec 2019, Hans de Goede wrote:
> >
> >> Hi,
> >> 
> >> Doing immutable branches assumes that there is a base point,
> >> e.g. 5.5-rc1 where the immutable branch can then be based on and
> >> that the branch can then be merged without issues into both subsystems.
> >> 
> >> drm is constantly evolving to deal with and mostly catch up with new
> >> hardware as both GPUs and display-pipelines are evolving quite rapidly
> >> atm drm-intel-next has about 400 commits on top of 5.5-rc1 so for an
> >> immutable branch I can either base it on drm-intel-next which
> >> violates your request for a clean minimal branch to merge; or I can
> >> base it on 5.5-rc1 which leads to a big chance of problems when
> >> merging it given to large amount of churn in drm-intel-next.
> >
> > This is a *slightly* more compelling reason than the ones you've
> > previously provided.
> >
> >> So instead of the normal case of 2 subsystems seeing some changes
> >> on both side the case we have here is a part of a file which has
> >> not changed since 2015-06-26 in one subsys (and changing only
> >> a single line there!) and OTOH we have bigger changes to a subsys
> >> which see 400 patches land in the first week since rc1 .
> >
> > This is not.
> >
> >> I hope that you agree that in this case given the large amount of
> >> churn in drm-intel-next it makes since to just straight forward
> >> apply these patches on top of drm-intel-next.
> >
> > I have Acked this patch, but remember *this* is the exception rather
> > than the rule.  If/when we have a case where a contributor works
> > cross-subsystem with DRM and the code/file adapted is live (more
> > likely to change), I will have to insist on an immutable branch
> > strategy.  DRM will have to deal with that appropriately.
> 
> Hi, thanks for the ack and reaching an agreement with Hans, and sorry
> for not responding earlier.
> 
> It's not unusual for us to have topic branches for cross-subsystem or
> cross-driver changes, and I think usually we try to be accommodating in
> merging stuff through whichever tree it makes most sense. In fact my ack
> to do just that was my first response on this series [1].
> 
> So I don't really know why the fuss. We'll anyway deal with any
> cross-subsystem series on a case by case basis, depending on what makes
> most sense, and what suits all maintainers involved.

Perfect.  Thanks for the clarification.  I look forward to working
with you guys in the future.

Hans was making the case that this was impractical for DRM, due to the
amount of churn you guys receive, hence the discussion.  I'm very
pleased that this is not the case.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
