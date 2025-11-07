Return-Path: <linux-acpi+bounces-18611-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3893C3E0D5
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 01:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B996F3AFB3E
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 00:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ACC3009DA;
	Fri,  7 Nov 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAKoh/wK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E702EB5A2;
	Fri,  7 Nov 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476603; cv=none; b=KjtonAanq/jfVtGGJzagbIuw0N7h2gyXVajVBOhhElso216B4wBe9HoGy5iXQmMaHc96I36OFfcHQ4fL3Mpd7u23lxowfi4bqYwBex2qEVsfmPbAVXCLpcywrNDXyYGEI2TNthPOgXiFlLe5irQw7I2JUlScW4B4nB5Lny5zNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476603; c=relaxed/simple;
	bh=J6DK8914qKi298MkORyqsooyEmiDASCGi5X9vMb2iQc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D2HQx631YdRzSMlgyr8Vp/31OJ4u6TwDs3Tl8HbpA9OA1vpBXeYf3BmGSKcPhx3zbyAiRKTcsKq5hEPF/6Yxte9+mFl14QCSJpZEiVNH3huGxzKuDr72nv84ZG4Zl39khkcoTWaGcPTC33z632SmdVCmqXtVEWU9VFYPYB5VQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAKoh/wK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ED3C116C6;
	Fri,  7 Nov 2025 00:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762476603;
	bh=J6DK8914qKi298MkORyqsooyEmiDASCGi5X9vMb2iQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LAKoh/wKhypRjZjXx3XMhRjXV8lLGkWhMUYlvGfrQX/SY29R7708xYCwyYeD/2WK9
	 08vlyAs8PwgzCmSdNgUYuUIgALXsiBuvA1sV3kuK4C6ZlItwyK++flltpdj7mboHEQ
	 Ajx27DACL8KskbcPP5Faq/a8A52nmJ/IkoqTiOroN1jgioeS1v/U2nhkfW2Kc1wC1J
	 On7NRn4lAzYQiYqL5xt95tyJ9fLClmX4sTw24vbSUTRMj4qZZbfhfK9JYGXicf2dIr
	 ZNHua1qFPQjReBjCb9biW6rBrFx6jPNpiH7zWWxmpwFplPioAy4qZh65Oab0k79dLC
	 Uy/TMWBEEruwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7149439EF974;
	Fri,  7 Nov 2025 00:49:37 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0heXyzAAP5mH-kP9iS9yGJ-ceGFUJG5m-FL-rMMWx4eJg@mail.gmail.com>
References: <CAJZ5v0heXyzAAP5mH-kP9iS9yGJ-ceGFUJG5m-FL-rMMWx4eJg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0heXyzAAP5mH-kP9iS9yGJ-ceGFUJG5m-FL-rMMWx4eJg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc5
X-PR-Tracked-Commit-Id: 771e8f483583728cd2ef164f7c2256c4bf2adf4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a157bdfc8d23c3fbfbeea47ff721fe9ef254b25
Message-Id: <176247657596.436188.14174138608508406909.pr-tracker-bot@kernel.org>
Date: Fri, 07 Nov 2025 00:49:35 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 6 Nov 2025 22:27:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a157bdfc8d23c3fbfbeea47ff721fe9ef254b25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

