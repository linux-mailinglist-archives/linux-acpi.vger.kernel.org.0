Return-Path: <linux-acpi+bounces-10793-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F0A19942
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 20:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174AA18899BA
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A198A2163A1;
	Wed, 22 Jan 2025 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnJNvGkL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415A21639D;
	Wed, 22 Jan 2025 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737574853; cv=none; b=bBL0djQE+IpNNCY70o+WW8Oa0dNHmn7F2RK/BWjzsdpFFpFwx6cgIviPjTpQrOuDccbL4cxVwYKH0o4ff2H/8aaEyFyCGpvOD8otZ8z1jrNezewq86Yz5yyVoFOPehvu2yF9cFdA3G2cfUxwbntT0Mo/dO8EZ+8+sJS6HQF8j18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737574853; c=relaxed/simple;
	bh=htds9j/29J32HDN4MMgUvLEa0V0U8qKZuYfzJNLwDlo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hNtYoqv5DkMOoSxvZKBJ+s6taqkgjyv/WTHluXXhcqZCR4ZDPCkr+/QB4mK4NAYY0p972HR0LHpB6fnLSCFiR+cSXnjylayovzQXmoWFDdo1SLgz8L0l9j4QicCk8kd51P6k+aWpf6dqNf19OjxyYmqyY1L0Obhk+uuNhdK3rIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnJNvGkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51270C4CEE2;
	Wed, 22 Jan 2025 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737574853;
	bh=htds9j/29J32HDN4MMgUvLEa0V0U8qKZuYfzJNLwDlo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gnJNvGkLUgBrWT8YlGjk9TcrauUBWQo4Q9d1/B0V8UyeWB0T496SyyW8sInR8sV4H
	 WnLNS9GU7mjQIphC7gDuftRxAa9Jutv+R1VnVrWr9oWdKt0xh5sqln5PaZfTnKDOwn
	 u/XweFQwzQIxfe5wBJHOK7Tutu5x5RUe9sr0N80KnvN2+UXrN61+SHDYGVvsz96ktq
	 e+/CJrJyj7A+j2wPnnWItPzD7a33Q9LwebmwRcBz0R2LHNJwU/OJ31ZCFp/aHN0wNV
	 vmBt2DvyIloN0KgMQ9KlIRPojFzNaE4GR25LxaouoqogU8RucrPkr82FK4mrDhBW90
	 tw6g5wdCf6DCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AB22380AA6B;
	Wed, 22 Jan 2025 19:41:19 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i66dR+grMVZpVM9a1kB5kVHcdiVdDk-9KPxRy2PmTv+w@mail.gmail.com>
References: <CAJZ5v0i66dR+grMVZpVM9a1kB5kVHcdiVdDk-9KPxRy2PmTv+w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i66dR+grMVZpVM9a1kB5kVHcdiVdDk-9KPxRy2PmTv+w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.14-rc1
X-PR-Tracked-Commit-Id: d1ddf94665c6805a63659ab0b09ef626ecc2b0b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 603f162a02d5ccf0b3c5b2c6f488e456be81007f
Message-Id: <173757487780.794141.13706145279896812972.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 19:41:17 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 22:05:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/603f162a02d5ccf0b3c5b2c6f488e456be81007f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

