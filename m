Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4DF2C4465
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 16:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbgKYPt6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 10:49:58 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42997 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731189AbgKYPt6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 10:49:58 -0500
Received: by mail-oi1-f193.google.com with SMTP id v202so3289613oia.9
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 07:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mY0WrvYNIljbWqKzA0GJRBDbUCscPAVS4IlM74iQAg0=;
        b=VGnloPZkAPKSTs5EJmme1AEoFRPVrB2YgkjVwNYBwy5psG+nQdya2emKNRAhBL1adU
         qCBW/D+MdwtWMj1dqEH+cO8DmHLLTXxFJp9g2Zf6Ral46sty1CmKeCeLJ12OLFXxV82F
         TsTQhMchc4f85nlAZSl58Ay7LllNoq53gNLRrQRNOui4WkFPGpG+xwxyTCoN2oI0OtFM
         +Q9HRpzIXJjXAGLzXs9DgLmhntJUGFnfQKB25TNir7uJgo4wt8wIef/XwGptov+R91OM
         svENXeIS3NKZVxGPJodVu4SWVATqzZSSbMB9zgzpzJfBu+7br7ZJf2OpAsBN7AbhH5rr
         /PiA==
X-Gm-Message-State: AOAM532LD16PvBN908Ob6Amv9vLIPmgWCFeOWNcdly9xWXsh21U2tM5O
        iaPUrjlaFuBIi7CxCAfP+yrF+s68yrHALt3c37w=
X-Google-Smtp-Source: ABdhPJwTj+YCHLeNROjlvhJfRGyYwPTAUmweh1qboqGiQizs1FNOrf3G2y3YlMatgxWNI5r0NYzP8y6c74k1G9cHXe8=
X-Received: by 2002:aca:f15:: with SMTP id 21mr2657926oip.71.1606319390429;
 Wed, 25 Nov 2020 07:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com> <f33b4381ea3a4cf4b8e7f27676cd90ed@intel.com>
In-Reply-To: <f33b4381ea3a4cf4b8e7f27676cd90ed@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Nov 2020 16:49:39 +0100
Message-ID: <CAJZ5v0hxqydcoqTCDzR7O7Y4d71Qutx+k4sOmdvOY24f2-OWgg@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: Intel: catpt: Replace open coded variant of resource_intersection()
To:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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

On Tue, Nov 24, 2020 at 1:13 PM Rojewski, Cezary
<cezary.rojewski@intel.com> wrote:
>
> On 2020-11-24 10:56 AM, Andy Shevchenko wrote:
> > Since we have resource_intersection() helper, let's utilize it here.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >
> > Promised clean up for recently introduced helper.
> >
> > This has dependency to the patches currently in linux-pm tree. Other than that
> > everything else is already in upstream. Hence, logically it's better to push
> > thru Rafael's tree than wait one more cycle.
> >
> >   sound/soc/intel/catpt/core.h   | 11 -----------
> >   sound/soc/intel/catpt/loader.c |  2 +-
> >   2 files changed, 1 insertion(+), 12 deletions(-)
> >
>
> Thanks for the patch, Andy.
>
> I hope you didn't get the impression I somehow forgotten about this : )
> Wanted to make it part of "cleanup/code reduction" after addition of
> last two missing features (fw traces + external module support).
>
> Fixes and removal of lpt-specific code were the priority though.
> As change is already here, I don't see any reason for delaying its
> merge:
>
> Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

Applied as 5.11 material, thanks!
