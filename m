Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E921122CCC
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 14:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfLQNZg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 08:25:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:34728 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfLQNZg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Dec 2019 08:25:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 05:25:35 -0800
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="209700078"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 05:25:31 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mfd: intel_soc_pmic: Rename pwm_backlight pwm-lookup to pwm_pmic_backlight
In-Reply-To: <20191217081127.GI18955@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191210085111.GQ3468@dell> <a05e5a2b-568e-2b0d-0293-aa937c590a74@redhat.com> <20191212084546.GA3468@dell> <d22e9a04-da09-0f41-a78e-ac17a947650a@redhat.com> <20191212155209.GC3468@dell> <4d07445d-98b1-f23c-0aac-07709b45df78@redhat.com> <20191213082734.GE3468@dell> <d648794d-4c76-cfa1-dcbd-16c34d409c51@redhat.com> <20191216093016.GE3648@dell> <fc3c29da-528d-a6b6-d13b-92e6469eadea@redhat.com> <20191217081127.GI18955@dell>
Date:   Tue, 17 Dec 2019 15:25:29 +0200
Message-ID: <87immfyth2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 17 Dec 2019, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 16 Dec 2019, Hans de Goede wrote:
>
>> Hi,
>> 
>> Doing immutable branches assumes that there is a base point,
>> e.g. 5.5-rc1 where the immutable branch can then be based on and
>> that the branch can then be merged without issues into both subsystems.
>> 
>> drm is constantly evolving to deal with and mostly catch up with new
>> hardware as both GPUs and display-pipelines are evolving quite rapidly
>> atm drm-intel-next has about 400 commits on top of 5.5-rc1 so for an
>> immutable branch I can either base it on drm-intel-next which
>> violates your request for a clean minimal branch to merge; or I can
>> base it on 5.5-rc1 which leads to a big chance of problems when
>> merging it given to large amount of churn in drm-intel-next.
>
> This is a *slightly* more compelling reason than the ones you've
> previously provided.
>
>> So instead of the normal case of 2 subsystems seeing some changes
>> on both side the case we have here is a part of a file which has
>> not changed since 2015-06-26 in one subsys (and changing only
>> a single line there!) and OTOH we have bigger changes to a subsys
>> which see 400 patches land in the first week since rc1 .
>
> This is not.
>
>> I hope that you agree that in this case given the large amount of
>> churn in drm-intel-next it makes since to just straight forward
>> apply these patches on top of drm-intel-next.
>
> I have Acked this patch, but remember *this* is the exception rather
> than the rule.  If/when we have a case where a contributor works
> cross-subsystem with DRM and the code/file adapted is live (more
> likely to change), I will have to insist on an immutable branch
> strategy.  DRM will have to deal with that appropriately.

Hi, thanks for the ack and reaching an agreement with Hans, and sorry
for not responding earlier.

It's not unusual for us to have topic branches for cross-subsystem or
cross-driver changes, and I think usually we try to be accommodating in
merging stuff through whichever tree it makes most sense. In fact my ack
to do just that was my first response on this series [1].

So I don't really know why the fuss. We'll anyway deal with any
cross-subsystem series on a case by case basis, depending on what makes
most sense, and what suits all maintainers involved.


Thanks again,
Jani.


[1] http://mid.mail-archive.com/87pnhnyir8.fsf@intel.com



-- 
Jani Nikula, Intel Open Source Graphics Center
