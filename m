Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFFE122A35
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 12:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfLQLg0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 06:36:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:17323 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLQLg0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Dec 2019 06:36:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 03:36:26 -0800
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="209664438"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 03:36:21 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [CI 0/3] drm/i915 / LPSS / mfd: Select correct PWM controller to use based on VBT
In-Reply-To: <20191216202906.1662893-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191216202906.1662893-1-hdegoede@redhat.com>
Date:   Tue, 17 Dec 2019 13:36:19 +0200
Message-ID: <87lfrbyyj0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 16 Dec 2019, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi All,
>
> Somehow the CI system did not pick up this series the first time, there
> are no test results recorded for it:
> https://patchwork.freedesktop.org/series/69685
>
> So this is a resend for CI to do its thing. As soon as CI is happy with
> this I will push this to drm-intel-next-queued.

Thanks, please go ahead.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
