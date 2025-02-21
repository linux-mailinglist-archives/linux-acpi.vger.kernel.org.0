Return-Path: <linux-acpi+bounces-11376-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C16A3FDA5
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 18:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F411678A6
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A02505DF;
	Fri, 21 Feb 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAfFX70i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CA824CEC2;
	Fri, 21 Feb 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159725; cv=none; b=TBw2hkmlMhtgzcJUNNRICIjoZIzc9xjxDl0ZgfBYpklYbdUamE6Plc24z93S0y5NpQ5n392J+dsLLg+fANhkTQpbrBddGcjWF3gsQf3tYPk6ZmZpigl8Sm+jLJnl0bO5F+lft7pXJfYoa46cHZwU+6lclLSh+ohougzSLf8vLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159725; c=relaxed/simple;
	bh=iz1VC4b0KuPvyY6vlNehniau7YMJj9IwJR7g9nVom8Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=la2iqAvlsFrDH/qWdOGLqAgCMY8h23EhvynIM8e/RXUJJZmh4WIGGQc6Z7qoAfjrlg2g0r4SgHGjBLrsTPpXCwpTeN3uYu8/xyHzyxK5+0JSI/yPWpsKjatpMdbSe0lomxVIQHwZxjJI1SYU7zOGVAdZo4MJcne7iAoDG+381wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAfFX70i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1185CC4CED6;
	Fri, 21 Feb 2025 17:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740159725;
	bh=iz1VC4b0KuPvyY6vlNehniau7YMJj9IwJR7g9nVom8Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DAfFX70imIc0+1Ruepuxl/FguQclzh/w9daHbg9FWlW0ATJwFojUyCA5CXbTDOLRp
	 35mxzHFoWF7g6i2oJ2IfoBq0P2BFUFyowN/Ra12WZc6jAKZHeOiSREe2c9MiPl/8D6
	 XFPzLA6wmI0mhNd7PHEqKT+g/Lu1Lc49WKyGxL8SwIDbPRmnvkNa5XAZC68KmSipH+
	 bfqiriutzeI3E+xXY8C/IyoI1koOTm5WcgIhfqNk5ZEszT6r5e09JKytDMN980KZda
	 9krFDah9pCM18tE7Cw/KLPZ8HCohAhZh7D5T8lPp+U2NyVs0hHoDrq4if3ElAG64Oa
	 H68jfKH2v0lsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FE1380CEEC;
	Fri, 21 Feb 2025 17:42:37 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hzMUGnqx=GfLUkVZXsMMqqguMV4S7Bf0z9EoPt4AYFaA@mail.gmail.com>
References: <CAJZ5v0hzMUGnqx=GfLUkVZXsMMqqguMV4S7Bf0z9EoPt4AYFaA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hzMUGnqx=GfLUkVZXsMMqqguMV4S7Bf0z9EoPt4AYFaA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.14-rc4
X-PR-Tracked-Commit-Id: d403120cb9d4787b283ea202b2162f459d18fe9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7108b48e9666a1cf010f83d65546666e17496f8b
Message-Id: <174015975574.2152716.17037433368150346574.pr-tracker-bot@kernel.org>
Date: Fri, 21 Feb 2025 17:42:35 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Feb 2025 17:30:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7108b48e9666a1cf010f83d65546666e17496f8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

