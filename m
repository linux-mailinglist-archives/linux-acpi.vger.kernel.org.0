Return-Path: <linux-acpi+bounces-13051-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109BCA89F9B
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228C1440BA5
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44D914B96E;
	Tue, 15 Apr 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLDgtq9o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349413213E;
	Tue, 15 Apr 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724234; cv=none; b=hAjMSHIkpupIPR9wjoCTdCcu3A6CGGFDvBLz2DYj6kNUkSi8XGSO33fIXHvZI5+vAdNr1S1WLU9ZbHWXkRExxQoscP5Mgs0hcuVQ1LQQyYvS/XRsbFHBcC+inVRm5RXyoxyRZGI0pbCr00EqT4351G5IBEvTOOp3RyJep/KOTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724234; c=relaxed/simple;
	bh=85JkuN0Px5AD9Z7YC2RwrWx8lyRHhaIkRQ7MKPa/Tf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nxja0oogRy+dp/nmS5D2ieg/6Md57ojQDmSip8W4NxWYNdnlK0b7g+0+y0Cq1pHew4aH4oNgCQsS6gpOqkCmP3973JCQdeszIPXcoTiSdr9wEIFKyB64IhrLfCje/S9C7votzXzwIwahizzCBSt+UOWp08Owslf3sh4qi1/CIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLDgtq9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F68FC4CEE5;
	Tue, 15 Apr 2025 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744724234;
	bh=85JkuN0Px5AD9Z7YC2RwrWx8lyRHhaIkRQ7MKPa/Tf4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qLDgtq9o237FW/gvYg5q4vxBH4KPryLpDKNqDcChjL0ZWJzVnuNSDusTOw5ZxHnjv
	 60jiLJHRLaIPYQMtgpv51KKuvQX1ty5EeGc/KanZqP6yU79MrOJzlaoqt3V2TzCHHX
	 KdH4FBMOzTB25cMLXD42zw4B0bgL7J21gB2NtB4SpylkRuKuQQ/WIL7XFbJ5RKTwy7
	 JPItnLVMHoVY50+ovsuJdEKnNeS7/6gz5Bzh402igLz6Ct+QN21gOxf2Pusn8KCwXC
	 TPGDzKJqZBTmwEr6T3exIlH9I3fgqkLm0O5PFSc+dkbqq6RgO0b8RNovkgB8Cr/pX/
	 ZTSyRCdpNFmbQ==
Message-ID: <6f7c9675-e86c-4d61-9d47-d92a9746b693@kernel.org>
Date: Tue, 15 Apr 2025 08:37:11 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: amd: Fix use of undeclared identifier
 'pinctrl_amd_s2idle_dev_ops'
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 kernel test robot <lkp@intel.com>
References: <20250414203551.779320-1-superm1@kernel.org>
 <CACRpkdaHru55wo5MdVsRKRbfPS9Hv3vGxgXNi8eXGvAOQzyDww@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CACRpkdaHru55wo5MdVsRKRbfPS9Hv3vGxgXNi8eXGvAOQzyDww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/15/2025 8:34 AM, Linus Walleij wrote:
> On Mon, Apr 14, 2025 at 10:35 PM Mario Limonciello <superm1@kernel.org> wrote:
> 
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> `pinctrl_amd_s2idle_dev_ops` is hidden under both `CONFIG_ACPI` and
>> `CONFIG_PM_SLEEP` so the functions that use it need the same scope.
>>
>> Adjust checks to look for both, and while updating make it CONFIG_SUSPEND
>> instead as that's what the acpi header uses.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202504100420.88UPkUTU-lkp@intel.com/
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   Use CONFIG_SUSPEND instead of CONFIG_PM_SLEEP
> 
> This seems to be based on the previous fixes merged by Rafael?
> 
> Do I need to rebase on -rc2 or something to merge this patch?
> 
> Or can Rafael queue this too?
> In that case:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

Yeah; I think Rafael should take it as the other patches are in his 
tree.  No other pinctrl-amd stuff planned this cycle that I know about.

Thanks!

