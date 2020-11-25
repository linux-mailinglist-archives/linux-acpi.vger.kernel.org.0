Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4562B2C44B6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 17:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgKYQLC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 11:11:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32945 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbgKYQLC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 11:11:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id k26so3412151oiw.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 08:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/C0ll5xcZ0CylqJR6ttle4L4NJYDwahvYC5vMDg722E=;
        b=jQxFzbxH1MMclqPXSkpMn16ExRFaAPdxPYpN8wbPAVpXP8sxBSOeGxwIYQ2LCu5/jX
         0EVGdcxDJmfKTANguUnI+qL2F8g1qK+kY4d+4pkLNrbns1E6PhL+lYZrIVLYD/sLPPbS
         DFQbTA+YfTTRERPqtYPaqIUwz+YbdUL1+oEHg0jpm+ggohHZvMXJkgE4BENCBYiz4VtE
         Xpem7wHXyls4fufdTFhg6eekOfTfTM40dVFbQ2Rvpwk/w7RPlPq9BY0xgzPId8FlNJ2P
         0r64vSM0NPUwMocQRYQWg+lrByiBuuQr+Hich7Chsa53izcgbxoPEg1VMaDXO9gslljq
         nW+A==
X-Gm-Message-State: AOAM532R2/PK9ZL/N/Ws8tPL9Z3tMQmF7s7IfaU0BztalhE1xPIs00rD
        EtVFvsd3+aNnkN/zmngVIn2CqukzgFgxUxUomBU=
X-Google-Smtp-Source: ABdhPJxEnZaTiOxRsndntYhtVYaLQDpHjvyFDqQNe1j0GKBKkRGfG14Z1pNWHLudF7qiLOyUCNeH3wiCCYwh2xHsmLw=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr2638661oib.69.1606320661856;
 Wed, 25 Nov 2020 08:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
 <f33b4381ea3a4cf4b8e7f27676cd90ed@intel.com> <CAJZ5v0hxqydcoqTCDzR7O7Y4d71Qutx+k4sOmdvOY24f2-OWgg@mail.gmail.com>
 <20201125161028.GW4077@smile.fi.intel.com>
In-Reply-To: <20201125161028.GW4077@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Nov 2020 17:10:50 +0100
Message-ID: <CAJZ5v0huXtSDtQEmUHx4NmjJhFNOVUMktD_eJ06=fsmZB40ayw@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: Intel: catpt: Replace open coded variant of resource_intersection()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 25, 2020 at 5:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 25, 2020 at 04:49:39PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 24, 2020 at 1:13 PM Rojewski, Cezary
> > <cezary.rojewski@intel.com> wrote:
>
> ...
>
> > Applied as 5.11 material, thanks!
>
> Thanks!
>
> There is one fix to the series [1]. But now I realized that I forgot to Cc
> linux-acpi@. Do you want me resend it?

Yes, please!
