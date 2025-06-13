Return-Path: <linux-acpi+bounces-14370-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D9AD9699
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 22:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675963BB688
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 20:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A642825393D;
	Fri, 13 Jun 2025 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6k7PsqN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99424EAAF;
	Fri, 13 Jun 2025 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749847339; cv=none; b=n++1z5rfCU1waH6fQhNnnKP0S5jJHwmp+wjtTbpZF5IQh5eeB5NHSI6/GaXmRM6uq//kQT8f+gp6SFcm6ITHp/Tc+IHD7QMM8lRdn/DDyThA1Vu3wC8zs+blUEe+e8FQ9IBn/XbTbQvnfScwIsoUKnlYCxK22IBkUvLNRkUQc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749847339; c=relaxed/simple;
	bh=srMRTi7J84pyB+1BLoKlGHcFpruqTeDi/tZBBrbDO/M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OtZf3nK3Yr8Oj/GkKdgTfAnQh21/4Nf8E3hYfODx5bC15Zkn5XpWCHmxVCZaaA5nUMjfXRzaK5t5Qoay8vC0PVwv95F5F9ZyAnmzkg2OY7tBVhj4N9cstRrKInCimcx+zMXXmD0oDd/gVEpYxneQtytdusbCW7x1N1k6QMmaMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6k7PsqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0D5C4CEF0;
	Fri, 13 Jun 2025 20:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749847339;
	bh=srMRTi7J84pyB+1BLoKlGHcFpruqTeDi/tZBBrbDO/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U6k7PsqNJbIQel5MVgcv0NjjHbBjXh36qGOMkfJV4Uj1bV6eXfqRXykY3Dkuod5cI
	 cGNBkQPFXVpoNM6obOieY70BiljWi148vYYYjRtXC1bSfe6EuNynsoXWnTCr1MGbkv
	 JH/gqHwmgp89ksOuhXhCzxsH/nUkK1hor11LD3suPXLtpKl8VCxqSnolhH3qmmhbGP
	 FwzcpWcEbbJ7NbEuH7Hvtnqd7ThM08TYAm7lk259B4PAtXyah99kt728s7QSLkdcay
	 FbmV5NgqeVHKc6g9/8E7jVPDPKzVxKTmQDN5chE7t/abucNhmNJZtXQ3XV9QiWYJl9
	 RMiQOOiZ5jWOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A4C380AAD0;
	Fri, 13 Jun 2025 20:42:50 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.16-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i=QhToT6d7jKUUTfm8HbH2FyfEk8xDF5NRj4JFKqtBLA@mail.gmail.com>
References: <CAJZ5v0i=QhToT6d7jKUUTfm8HbH2FyfEk8xDF5NRj4JFKqtBLA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i=QhToT6d7jKUUTfm8HbH2FyfEk8xDF5NRj4JFKqtBLA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.16-rc2
X-PR-Tracked-Commit-Id: 28b069933d39708af872d9739e78315317b93031
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18531f4d1c8c47c4796289dbbc1ab657ffa063d2
Message-Id: <174984736879.883745.4597417038135021945.pr-tracker-bot@kernel.org>
Date: Fri, 13 Jun 2025 20:42:48 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Jun 2025 22:16:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18531f4d1c8c47c4796289dbbc1ab657ffa063d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

