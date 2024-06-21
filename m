Return-Path: <linux-acpi+bounces-6574-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 153CF912D28
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 20:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CFE1F258C4
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F4179206;
	Fri, 21 Jun 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhCspVgn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE516A945;
	Fri, 21 Jun 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994390; cv=none; b=D9DQPKIXLP0Diw7M8Tcd2AqP/GS0ghSD9Edf/+QVPNWtGghwDY7s8ESqCbfvtuPYy4S//aSED/65l3he9b8TNi6bCTb54enuhX+va5NGDw/gXWG4TO3V/2P6gnjRw/QH1fLw3qlS23Q0jzwIzw23XVXWbxXKMWfLSULp8wUcv3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994390; c=relaxed/simple;
	bh=cPMWz2qEOUB27vGzH6EfT3xXEbOxNW12YfWpOnbYQPM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aUxBF0SM7N3oobWMMtemNVFGIZVRP6jcxOnBzIH0/YMgzTswg9Ut5EZu9YKtQRFMacBiaYsjvb0IkPXcgINcQZVr8j/ry78Im1EzBFhbBdNWwc3u492KhFX0p4hAAYD/uvMdgwFd3sApFQ9wA8TUXEuRg6o8BmsCPnVZAAECUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhCspVgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB497C4AF08;
	Fri, 21 Jun 2024 18:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718994390;
	bh=cPMWz2qEOUB27vGzH6EfT3xXEbOxNW12YfWpOnbYQPM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WhCspVgnwxMCSMJSoGcHWtegkfY6JWYewYIcBz+5Tu0N+Eb3SgmjV5Bzb6SsCfVId
	 3tOfUs5xjc4icI/CVpxxkIW6p/52e+FJJMBQHhEAjxBCdtd5vymKhhe0beOxLy4KPT
	 L7++pF9nf5aUaIpONarRQw15zEngzUJhwhxgEX1EMPkIFdJoz9cnEaTD1YGw1GS/2Y
	 XXBuwqQLkNEqwlBhPm20L2RJAbLI0xFwQhlG0Wq5XIJFTL5TU6+/H4/0kGJ8jlboSZ
	 Z0gUIfOZBwBrE3rwDhnyNPtvmaCRkqylGC52WdE9J1KW9Z3MIikjw3ZkG5CNShfb8+
	 HPCRObFXQVHcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90D0ECF3B97;
	Fri, 21 Jun 2024 18:26:30 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jiAQKKgOdqwmWGTMHWoz2Cf_P8ASU9KxWbFCN=7EgnnQ@mail.gmail.com>
References: <CAJZ5v0jiAQKKgOdqwmWGTMHWoz2Cf_P8ASU9KxWbFCN=7EgnnQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jiAQKKgOdqwmWGTMHWoz2Cf_P8ASU9KxWbFCN=7EgnnQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc5
X-PR-Tracked-Commit-Id: 5e409a29171c5ce22d21d5b0ae88bfce780643ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36c075837496b8c8509bfbe648ddde22b1763641
Message-Id: <171899439058.27430.8297945282646361369.pr-tracker-bot@kernel.org>
Date: Fri, 21 Jun 2024 18:26:30 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Jun 2024 14:37:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36c075837496b8c8509bfbe648ddde22b1763641

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

