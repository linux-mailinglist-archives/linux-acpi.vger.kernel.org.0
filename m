Return-Path: <linux-acpi+bounces-14940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AFEAF5AAE
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D368D3A5292
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7A2BDC02;
	Wed,  2 Jul 2025 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzVfcQmI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989F2BD037
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465528; cv=none; b=GNEtfmROFpLSmTKNWtpW8jYSU3Ia6nVlUDIlPqYpdJUkq7ZQsA08mlJjczhZCVXmb7XRAQxl4MvUhynpmY+4i5E2Ug3D6zXKF1z+61OjvN6JDkbHMG8Y1K2ZiPn5eSeQ/Sz9KfDlJkhSWZv73Fjx2Fxrqhb4PBOzirTGpQNZwEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465528; c=relaxed/simple;
	bh=JRJPH4m3gHOL8iOAGjaKdf0GbC0HHnVxh4Krznoo3KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX1AbHJUfy3mFvpINOpRpcLwaEBHM1/C1EtYiND2dPBF0Cvx9pqY8unLtod2TpQZUO87InSj4rJv4NW1VBCVsZpxMcGqvL/zHxaIJinzP/9/IISEMjtJCRrQ595Jjfdiey/hm5mko2Q2TmH3HWwUe9OT1fz2Lv9PoW7rGmhU3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzVfcQmI; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso4154778276.2
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jul 2025 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751465526; x=1752070326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1mPoU1UCDxjl6IWc+jKm50U28f8v3ln7LdhgS9xFHd8=;
        b=JzVfcQmIhRCBHkY7YMzvyyFHMH69W22USFiAIMlmWmJViWurdbP3UXDxOUX/ZB56DH
         hriNNwFVMwhrsnyiXPsNHLdpwjXlAG2x+RN9Q44qwoBOFBbdXt1KEqsvlGpS550s0Xk9
         wCrC1VKfTa4IMjvM3dLfwA/PYLwedmkAUXB+xPSJBbLsBAfjM9n+qNtzysq6H1G/qPix
         +OruNqP2iKwIQPLiWDoDjNFmDj7wxRhmOqn/8b4FqR27y7826azVnBmT4XnY/JcXfYrM
         sN08NyOhntVoojALkTFFZERbXodeU2OqZN9wWLhfwJOHfzn43EZRRv+nTDnxxxKdzA+N
         tNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465526; x=1752070326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mPoU1UCDxjl6IWc+jKm50U28f8v3ln7LdhgS9xFHd8=;
        b=NIuj9l0J65T9ka21tVRBV5Ku9Oxifcm8hJvibhkrIEJNwyYiQGHIAYhO3ZPC23fMgg
         8v5YxO/Bwd3U8s021me8Kp/jSqSHjbHRumuId4gVLTpkZ8xgwv5TkrZXw8bkq7HElbwY
         t1jZymFrDWXwWc6i738KdLormlm5hrszf8cnF/YJ0+p6WeBQeFYhW47/JTI1shBUvGJC
         uPnWsbv87SY54gp6f5+BGAmnzFCJX65vB+H/DB9FVch3cBUU6dZIOSHZNyEx1kKBUCL0
         DmCd7zIR+NFWFJFAqSOdu8kBa3CYPTy8LCk7hWD7v7Fe3M5oDYgsndvhXtMpNRw7MNvY
         o5pg==
X-Forwarded-Encrypted: i=1; AJvYcCUXo5hFZI09K7CL0s7pZ4ta/cYlGvL2OLDeFFUGsge/7dhmp1jXnscXAEx5mn9x3pp7zIQ0PYZY0N4X@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcug1sLMRp8+fBToYxYbdiHVoeHFhjO2N9EpYhaVpAysfAYzjq
	oOzZVW0QRiwOpJRglk/LMRkFHzj2NcLjABWbDdGTvT37WXUMqmBzkMAa+aQ0M24qTkBC6aUJ4LN
	ZcXQsGT2yAkiissq9Hcmd9+TWzeLU88dmtq1KzatmBA==
X-Gm-Gg: ASbGncsiL+wHiJuyafQutC9ZPKOJNZ1h/h7E2UOfnuwGW3Odm6DTxqtLIfAJTQqZkk+
	s/zCPekSxun6DW3f9+Bu0lkNxnaqNWQBXEMC3kP3EaJMGmKEGJa6y7rqWduvUmhqYG0ObQ4bUCq
	bSN51DqQOVRBq+blLXLmjjzlTddVkKT628yVqTsXMAKSyL
X-Google-Smtp-Source: AGHT+IHPaXrxmHFVKX7Eql3EMD5x4On0T3oI0issqDZiJ0MoiOv4sD7i0/jMP72156cYMAUC8axQa4qkX4Dj4M+kpkU=
X-Received: by 2002:a05:690c:6213:b0:70e:7882:ea91 with SMTP id
 00721157ae682-7164d4b88d2mr41815867b3.35.1751465525819; Wed, 02 Jul 2025
 07:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5018768.GXAFRqVoOG@rjwysocki.net>
In-Reply-To: <5018768.GXAFRqVoOG@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Jul 2025 16:11:30 +0200
X-Gm-Features: Ac12FXynITunG4rG5UQO1EB1vzYUCxa7rAXh-RE6XqfZ0CLPy3V92JuMPVtw6hI
Message-ID: <CAPDyKFp35SjpQmEQ02u7ZbsaFftaett_rBBf-7hbsBpGWH08hw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] PM: Reconcile different driver options for runtime
 PM integration with system sleep
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 21:29, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Everyone,
>
> This is an update of the series the v2 of which was posted yesterday:
>
> https://lore.kernel.org/linux-pm/5015172.GXAFRqVoOG@rjwysocki.net/
>
> and the v1 is here:
>
> https://lore.kernel.org/linux-pm/22759968.EfDdHjke4D@rjwysocki.net/
>
> This update reorders the patches (again), updates the changelogs of some of
> them and changes the subject of one patch slightly.  It also adds a kerneldoc
> comment to a new function in patch [5/9].
>
> This part of the cover letter still applies:
>
> "This series addresses a couple of issues related to the integration of runtime
> PM with system sleep I was talking about at the OSMP-summit 2025:
>
> https://lwn.net/Articles/1021332/
>
> Most importantly, DPM_FLAG_SMART_SUSPEND cannot be used along with
> pm_runtime_force_suspend/resume() due to some conflicting expectations
> about the handling of device runtime PM status between these functions
> and the PM core.
>
> Also pm_runtime_force_suspend/resume() currently cannot be used in PCI
> drivers and in drivers that collaborate with the general ACPI PM domain
> because they both don't expect their mid-layer runtime PM callbacks to
> be invoked during system-wide suspend and resume.
>
> Patch [1/9] is a preparatory cleanup changing the code to use 'true' and
> 'false' as needs_force_resume flag values for consistency."
>
> Patch [2/9] (which was [3/9] in v2) puts pm_runtime_force_resume() and one
> other function that is only used during system sleep transitions under
> CONFIG_PM_SLEEP.
>
> Patch [3/9] (which was [5/9] in v2) causes the smart_suspend flag to be taken
> into account by pm_runtime_force_resume() which allows it to resume devices
> with smart_suspend set whose runtime PM status has been changed to RPM_ACTIVE
> by the PM core at the beginning of system resume.  After this patch, drivers
> that use pm_runtime_force_suspend/resume() can also set DPM_FLAG_SMART_SUSPEND
> which may be useful, for example, if devices handled by them are involved in
> dependency chains with other devices setting DPM_FLAG_SMART_SUSPEND.
>
> Since patches [1,3/9] have been reviewed already and patch [2/9] should not
> be particularly controversial, I think that patches [1-3/9] are good to go.
>
> Patch [4/9] (which was [2/9] in v2), makes pm_runtime_reinit() clear
> needs_force_resume in case it was set during driver remove.
>
> Patch [5/9] (which was [4/9] in v2) makes pm_runtime_force_suspend() check
> needs_force_resume along with the device's runtime PM status upfront, and bail
> out if it is set, which allows runtime PM status updates to be eliminated from
> both that function and pm_runtime_force_resume().  I recalled too late that
> it was actually necessary for the PCI PM and ACPI PM to work with
> pm_runtime_force_suspend() correctly after the subsequent changes and that
> patch [3/9] did not depend on it.  I have also realized that patch [5/9]
> potentially unbreaks drivers that call pm_runtime_force_suspend() from their
> "remove" callbacks (see the patch changelog for a bit of an explanation).
>
> Patch [6/9] (which has not been changed since v2) makes the code for getting a
> runtime PM callback for a device a bit more straightforward, in preparation for
> the subsequent changes.
>
> Patch [7/9] introduces a new device PM flag called strict_midlayer that
> can be set by middle layer code which doesn't want its runtime PM
> callbacks to be used during system-wide PM transitions, like the PCI bus
> type and the ACPI PM domain, and updates pm_runtime_force_suspend/resume()
> to take that flag into account.  Its changelog has been updated since v2 and
> there is a new kerneldoc comment for dev_pm_set_strict_midlayer().
>
> Patch [8/9] modifies the ACPI PM "prepare" and "complete" callback functions,
> used by the general ACPI PM domain and by the ACPI LPSS PM domain, to set and
> clear strict_midlayer, respectively, which allows drivers collaborating with it
> to use pm_runtime_force_suspend/resume().  The changelog of this patch has been
> made a bit more precise since v2.
>
> That may be useful if such a driver wants to be able to work with different
> PM domains on different systems.  It may want to work with the general ACPI PM
> domain on systems using ACPI, or with another PM domain (or even multiple PM
> domains at the same time) on systems without ACPI, and it may want to use
> pm_runtime_force_suspend/resume() as its system-wide PM callbacks.
>
> Patch [9/9] updates the PCI bus type to set and clear, respectively, strict_midlayer
> for all PCI devices in its "prepare" and "complete" PM callbacks, in case some
> PCI drivers want to use pm_runtime_force_suspend/resume() in the future.  They
> will still need to set DPM_FLAG_SMART_SUSPEND to avoid resuming their devices during
> system suspend, but now they may also use pm_runtime_force_suspend/resume() as
> suspend callbacks for the "regular suspend" phase of device suspend (or invoke
> these functions from their suspend callbacks).  The changelog of this patch has
> been made a bit more precise since v2, like the changelog of patch [8/9].
>
> As usual, please refer to individual patch changelogs for more details.
>
> Thanks!
>

For the v3 series, please add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

