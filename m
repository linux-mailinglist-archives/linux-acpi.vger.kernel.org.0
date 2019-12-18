Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC312401E
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2019 08:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfLRHOt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Dec 2019 02:14:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:64110 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLRHOt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Dec 2019 02:14:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 23:14:48 -0800
X-IronPort-AV: E=Sophos;i="5.69,328,1571727600"; 
   d="scan'208";a="209988246"
Received: from asama-mobl.amr.corp.intel.com (HELO localhost) ([10.252.50.109])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 23:14:43 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
In-Reply-To: <20191217135140.GL18955@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191212084546.GA3468@dell> <d22e9a04-da09-0f41-a78e-ac17a947650a@redhat.com> <20191212155209.GC3468@dell> <4d07445d-98b1-f23c-0aac-07709b45df78@redhat.com> <20191213082734.GE3468@dell> <d648794d-4c76-cfa1-dcbd-16c34d409c51@redhat.com> <20191216093016.GE3648@dell> <fc3c29da-528d-a6b6-d13b-92e6469eadea@redhat.com> <20191217081127.GI18955@dell> <87immfyth2.fsf@intel.com> <20191217135140.GL18955@dell>
Date:   Wed, 18 Dec 2019 09:14:47 +0200
Message-ID: <87a77q14wo.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 17 Dec 2019, Lee Jones <lee.jones@linaro.org> wrote:
> Hans was making the case that this was impractical for DRM, due to the
> amount of churn you guys receive, hence the discussion.  I'm very
> pleased that this is not the case.

Heh, well, it is the case, but the point is that should be our problem,
not yours. ;)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
