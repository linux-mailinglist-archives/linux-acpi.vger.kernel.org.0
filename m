Return-Path: <linux-acpi+bounces-6170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0338FB2FD
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 14:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C61281C35
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542F14659C;
	Tue,  4 Jun 2024 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="so8G+/r2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A61465A0;
	Tue,  4 Jun 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505696; cv=none; b=usSVvh91W36gTgLu20wYtQIMAJt/H7XBHNbalUnmFTV4qoqVvP9QRe5w+uLCe/zK/lRijJV+sSXMU2oqcssoNnJlnXUw2Ah7YK+LL0fKmnlq/iFXNQrb4SwVffdx+mSzT4Yo4bfmrbwbGNR3dt1FifMtpqbFfrJczt4JxOKO7DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505696; c=relaxed/simple;
	bh=6r0nPGrlvbLTowPbiR+YL8Z4O8Ed6VNmvaDIlB0sKBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p48wiz1+lY50R5cavvpWjDWkjh0rcfqUfCDCnsUB8T3fSSXEO6vKA0bdalvxREdpZSr9UltHWSYnJ//wRGEDRlZSLHMrm1lRWHmJHRdvxOhlPNOmIhEUwLBdPEcOw6D30HtdBv7X9AlQAhlVkrMdHE1EdiDIrTo0QJbMVj4EaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=so8G+/r2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717505692;
	bh=6r0nPGrlvbLTowPbiR+YL8Z4O8Ed6VNmvaDIlB0sKBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=so8G+/r2yS3Zspfmcg9MYYNewDV9qpcRNV9MvT2PnyEP9RM347CUdAJxF+RjZ6G83
	 mWbzWit58s0SPgRI6uV6hh6Rlh0qNF9FgzSs8qXVk12ssqudyZBnh7EJZAzpeDRojv
	 uDfmRVOXTWBUUqGdS/P5xhxy7JzF2Ts0te8ml0fMKCrhYJHD/c/X6r+MEmhKmXS4v2
	 Zu2daHxwdsdm5YDEt/ZuachZiaRmOz6aes9HhCWJVGzoj/R3onNCapuEgoBx6KUBjo
	 fqdmcT30WAU3AccMEVQ5C37xqXjdXgAOq2hffSPyK4GS5tzpl7KF8uye3BrTBO5rMI
	 0WtSYrcdtL6Cg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B82893782173;
	Tue,  4 Jun 2024 12:54:51 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: rafael@kernel.org
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] probe with driver acpi-fan failed with error -22
Date: Tue,  4 Jun 2024 14:55:09 +0200
Message-Id: <20240604125509.553786-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAJZ5v0jP4TKojEMcMutptYFC=o0zJLyHfCBVOdcwp4tzSNK_4A@mail.gmail.com>
References: <CAJZ5v0jP4TKojEMcMutptYFC=o0zJLyHfCBVOdcwp4tzSNK_4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 6/4/24 14:07, Rafael J. Wysocki wrote:
> On Mon, Jun 3, 2024 at 8:20 PM Rafael J. Wysocki <rafael@kernel.org>
> wrote:
>>
>> Hi,
>>
>> On Fri, May 31, 2024 at 1:35 PM Laura Nao <laura.nao@collabora.com>
>> wrote:
>>>
>>> Hello,
>>>
>>> On 5/30/24 17:37, Laura Nao wrote:
>>>> Hello,
>>>>
>>>> We have identified a regression in the acpi-fan driver probe
>>>> between
>>>> v6.9-rc7 and v6.10-rc1 on some Intel Chromebooks in the Collabora
>>>> LAVA
>>>> lab.
>>>>
>>>> For the Acer Chromebook Spin 514 (CP514-2H), the following error is
>>>> reported in the logs:
>>>>
>>>> [    0.651202] acpi-fan INTC1044:00: probe with driver acpi-fan
>>>> failed with error -22
>>>>
>>>> Similar errors are reported on other devices with fans compatible
>>>> with
>>>> the same driver.
>>>>
>>>> On Acer Chromebox CXI4, ASUS Chromebook Flip C436FA and
>>>> HP Chromebook x360 14 G1:
>>>>
>>>> [    0.488001] acpi-fan INT3404:00: probe with driver acpi-fan
>>>> failed with error -22
>>>>
>>>> On ASUS Chromebook Vero 514 CBV514-1H:
>>>>
>>>> [    1.168905] acpi-fan INTC1048:00: probe with driver acpi-fan
>>>> failed with error -22
>>>>
>>>> The issue is still present on next-20240529.
>>>>
>>>> I'm sending this report to track the regression while a fix is
>>>> identified. I'll investigate the issue/run a bisection and report
>>>> back
>>>> with the results.
>>>>
>>>> This regression was discovered during some preliminary tests with
>>>> the
>>>> ACPI probe kselftest [1] in KernelCI. The config used was the
>>>> upstream
>>>> x86_64 defconfig with a fragment applied on top [2].
>>>>
>>>> Best,
>>>>
>>>> Laura
>>>>
>>>> [1]
>>>> https://lore.kernel.org/all/20240308144933.337107-1-laura.nao@collabora.com/
>>>> [2] https://pastebin.com/raw/0tFM0Zyg
>>>>
>>>> #regzbot introduced: v6.9-rc7..v6.10-rc1
>>>
>>> The issue started happening after:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/thermal/thermal_core.c?h=v6.10-rc1&id=31a0fa0019b022024cc082ae292951a596b06f8c
>>>
>>> Before this commit, get_cur_state() was not called by
>>> __thermal_cooling_device_register, so the error was not triggered.
>>>
>>> After enabling debugging for the acpi-fan driver, I noticed these
>>> errors
>>> in the logs:
>>>
>>> [    0.682224] acpi INTC1044:00: Invalid control value returned
>>> [    0.682635] acpi INTC1044:00: Invalid control value returned
>>>
>>> The value stored in fst.control is 255, which is indeed not a valid
>>> value.
>>>
>>> I suspect this might be a firmware issue that is now manifesting due
>>> to
>>> the addition of the extra get_cur_state() call.
>>>
>>> I'll dig a bit more and report back.
>>
>> It looks like _FST returns all ones if it is evaluated before _FSL on
>> the affected platforms.
>>

Right, I'll look into that.

>> It shouldn't do that, but then it is not particularly useful to fail
>> cdev registration for this reason.
>>
>> The attached patch should work around this issue, please try it and
>> report back.
> 
> A !ret check is missing in that patch, so please try the attached new
> version of it instead.
>
> Thanks!

I confirm the patch works as expected and fixes the probe issue.

Thank you!

Laura

