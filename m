Return-Path: <linux-acpi+bounces-14684-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36256AE9B89
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 12:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BA316803F
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 10:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F7259C98;
	Thu, 26 Jun 2025 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1hIo8mD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42023815D
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933883; cv=none; b=nka01tiTDG6ZygLEBlZsC7PQ7/QJ2m9LwTbbFhPVvobqJDDgU8iqRS2GVOICHQ8ietqNfGhnvLMFCRXGl8luPz1bk2awQu6G0nCXhNzLrna3ydVxF7yGF9iNGJAwqbpEWC73rbYb8s5ls3vdO3jJGKiJnjSZUP6x44j9q5DP0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933883; c=relaxed/simple;
	bh=Z+HMGmRN117Ts5fbev7DVAdsIy/tyxpazqxI06YJMls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTagVI82qD57qqdgjDG3uA+3vM1dsVElwfMuE1watbZgKtZORl8/kvump2lhHX2kyab9FBXeY1juB9o3yzC+mN/i2Y+o5SG9Sy1HX3zib5pQjZ/hQWOxoj+rBPIFrirw+odRh2gt1j/p/5Pzc7szsyH7sVk54oaQSMBb1CtXXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W1hIo8mD; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e81749142b3so586732276.3
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750933881; x=1751538681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=otDF7N1FhmMaIK9N2KC0Z8gh+57rBjHJAOPDBBdmpSg=;
        b=W1hIo8mDxjc4XL8RaKGRZkJ6cuFSVemaDKyeCUxqjY1uLH40BkyXLAcrJqwlFTi7oL
         YM4jeQHzHxzITESFipykSOhGAb2GgA6EE8vBxD6I3b5x29ipTqEj4cSVGJ1cukPLFGws
         8qN9qrvP/Xp4z9ncEHpmaytdBZjdNCNkYwLfjeDPUdiFzVwpzkXp4RTPE35m0CLh72pY
         AYg75X4vWKqLV+DjPb8pDonHhpHR2elnZjL/UqOcIOwldU4D+JH8nGjnsEKUVp4MZ1LV
         rz3l9XjBcJ7tKtAUwn9ToIL2qfNMtQjHkKPbNLO8+RANBy0gGvkSLQpP96PvfSS+WXMW
         5uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750933881; x=1751538681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otDF7N1FhmMaIK9N2KC0Z8gh+57rBjHJAOPDBBdmpSg=;
        b=RscD70y8PH7p/YrFgw1b0MBm2mdPYj/8xtXGPHrW/uSyEu/pc/cm3+rHoHAM7RbiiH
         o5RvgUf1vwsjjytZQW8g84YhqkF3DHiAMlB9pGVpqW4dSPlRSnL+v6loB1b6o4aiPzrv
         kaQAmZnmKxRQJ3loclIo2cC8w4ajIiZsDGXfBENVrLafcerUhO/TYUVNIRFxZhxF4+AV
         WJQJsK8YA4arwAZK5LCS94McSdyI8wQS0M27OQfUz0DxqvVGk7ai1YGZXeBwgUupUGIH
         wL6b+MlDXuKS928yg88DVhvbk4zOHzdn9Sqz/X+hN7Fh691MXDJOejF7+uY5rYDknGGJ
         w8pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi7KXCy9azMezEdEjP50EPPVClHPUUpYq+e0czTj2a+EtT8yh0sJEFmGQonqB5fZprADvvuUDfcxcP@vger.kernel.org
X-Gm-Message-State: AOJu0YyFq567AVwkBvubJIFpO6zvCEHmpmAfXB1S+vmzbeGOtG3IrcEt
	XCmLFtTliXgRSJugZAAvGzl2GLCEQsnizPmatHcw9B1/xK/5W1QBM6wLYwBeIjz1yzjGuDO4EBI
	WlAv+mjnocPcXoVj8VppjhWnA44by5gDq9hZ5YZxz5w==
X-Gm-Gg: ASbGncsfs/6kZFxh6qzC2pNG5wriNI4GYvqtjpIw3hLQbT8Q7HbcMpLR6ARpR5km17r
	ELBv1545uJemkPU9ZFF/PkTBmnZ+IJuSJFIQkXCGrdqlV1nMCJhboYqQzJDkyQl/5zD25NcKe1v
	cFxC7IltNizngdp054VwwFrXhedrc31hMGV+8Zix779sMk
X-Google-Smtp-Source: AGHT+IEJFJjQjgoF4JDK6/h8YGM8Hnkr8ICuxu9rc5onoooA/kJOCVLg4G5+xe4NPd23fJBgWQaeIr163WvTav7Ioko=
X-Received: by 2002:a05:6902:138c:b0:e84:2160:8d71 with SMTP id
 3f1490d57ef6-e86017c4ad4mr8521092276.40.1750933881094; Thu, 26 Jun 2025
 03:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net>
In-Reply-To: <22759968.EfDdHjke4D@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 12:30:45 +0200
X-Gm-Features: Ac12FXyTZUBODRjJn3UboKy92_g08xem5gzj1b0KboifHaz0N5A-9Sd_QQGZ6zw
Message-ID: <CAPDyKFpZVdf2EnZE_u1xDKB7=Nd98a_ajYimQhLBu6jYwJhJFA@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] PM: Reconcile different driver options for runtime
 PM integration with system sleep
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Everyone,
>
> This series addresses a couple of issues related to the integration of runtime
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
> 'false' as needs_force_resume flag values for consistency.
>
> Patch [2/9] makes pm_runtime_force_suspend() check needs_force_resume along
> with the device's runtime PM status upfront, and bail out if it is set,
> which allows runtime PM status updates to be eliminated from both that function
> and pm_runtime_force_resume().
>
> Patch [3/9] causes the smart_suspend flag to be taken into account by
> pm_runtime_force_resume() which allows it to resume devices with smart_suspend
> set whose runtime PM status has been changed to RPM_ACTIVE by the PM core at
> the beginning of system resume.  After this patch, drivers that use
> pm_runtime_force_suspend/resume() can also set DPM_FLAG_SMART_SUSPEND which
> may be useful, for example, if devices handled by them are involved in
> dependency chains with other devices setting DPM_FLAG_SMART_SUSPEND.
>
> The next two patches, [4-5/9], put pm_runtime_force_suspend/resume()
> and needs_force_resume under CONFIG_PM_SLEEP for consistency and also
> because using them outside system-wide PM transitions really doesn't make
> sense.
>
> Patch [6/9] makes the code for getting a runtime PM callback for a device
> a bit more straightforward in preparation for the subsequent changes.

I can't find this one. Seems like you did not submit it.

Perhaps make a resend and fixup the patch-numbering too?

[...]

Kind regards
Uffe

