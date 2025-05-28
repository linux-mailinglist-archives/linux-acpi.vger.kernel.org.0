Return-Path: <linux-acpi+bounces-13913-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EA0AC5E42
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD7CA20C00
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 00:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7771B532F;
	Wed, 28 May 2025 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEmX6c6C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E721B0F1E;
	Wed, 28 May 2025 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392154; cv=none; b=QCfT5MIbRikJ07a/SDRKjsU/g+YZUmiIHCZufuo79yaxYAjt3w6sUDxNNQMsvGflxHdj4aXKD/aUcqe2sOU//mhktQJXQDwrxtZVxZhnnbxnUWDApK+CLZ0YEOgENJLRfY1lOhtEkTyRDoZKKhpXifO0EoG4umqfUIj2Y5fj7NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392154; c=relaxed/simple;
	bh=8jhvWZ/LhFIrU5BfZSW3E6rOD8iTzQ6uljajCFoyayQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RomODzqHfeh+ppDzGAQsOvoBMqzKmDxNvOGCVWuKigf9QhOtBAoFXsn0T8Osxf1ewNwe03uBRus5bSzz+K+9AxaiVWBzevRVvrphDu8HLm+5aOEv3bfEc94rZGqxt4HplUhRRLsDHIadpZbZnrzCf68Je9YZ+A9HORGJk8yxOcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEmX6c6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83CDC4CEED;
	Wed, 28 May 2025 00:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392153;
	bh=8jhvWZ/LhFIrU5BfZSW3E6rOD8iTzQ6uljajCFoyayQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MEmX6c6CSgM+jTPeHo9+Urcc/n804Z2Qg0Mqi3wbhGeC//SGR6mK4Hgg2TfhwZrjt
	 /NszHlq0ntMW8mzUN6RgebYzDLjHJpsU6ZZne51TdabJo9bXqgBaZRSFCWE3gXc9Ru
	 h/tEdacYKIQIYoetawTpcG1LhQghqpHgdoo5DN2ePveaR9F6hFYsSGWAi7jNKyHHjm
	 /XhiOCf6pWU2oFLxHEQfWT3qqeNJCeqUFi+mr7lz6iZLg6dDZx0VLcHLIWnPxj8IJ9
	 ECG+XpJ61Ar/lAYtDIXefAHwzVF95sMN+3iSBnela3OMN2IhBAa98lQgvnzb6Qc8VE
	 yqfu8oXKQ2hEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C23380AAE2;
	Wed, 28 May 2025 00:29:49 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jtbcDUaMcTrnG7ewHmuMG2YUwe4ho1LUg-v9TrwLybLA@mail.gmail.com>
References: <CAJZ5v0jtbcDUaMcTrnG7ewHmuMG2YUwe4ho1LUg-v9TrwLybLA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jtbcDUaMcTrnG7ewHmuMG2YUwe4ho1LUg-v9TrwLybLA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.16-rc1
X-PR-Tracked-Commit-Id: 01daf71a4f57062055f68f8163ed1ad88fb47990
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 049294830bfaa1c4b56d5ccf21075f6f9990799e
Message-Id: <174839218780.1837144.10669862034035976057.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 00:29:47 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 26 May 2025 22:07:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/049294830bfaa1c4b56d5ccf21075f6f9990799e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

