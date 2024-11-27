Return-Path: <linux-acpi+bounces-9788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D399DAF96
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 00:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D24228202D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Nov 2024 23:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0909205ACB;
	Wed, 27 Nov 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dcyh9iU9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687B205AC3;
	Wed, 27 Nov 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748356; cv=none; b=umPp7sbk0LN+DJoNBxOQSno0tbYOBs+xD7NB9lYrM266PUlAurUvIk5K7O1/mQ+obFsyPhjKm1XnqVul+84qplasjtsKB/gZ9O+ePEabP2bk8SxXn+gQMaX7af2F2qlHxxXPQIGXLyHZQoXxehTLOYTH6ppQrgJjSnv+gy3/LDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748356; c=relaxed/simple;
	bh=7q+HprYzzC+BJkpdZIdCVuKvfPuexWA6NfRf5oftI5Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L80a6SLc7Feh2sZnixr0h++h9yBoCZoFmOwib0EjiwWNMP27cqLCIH8PL7TTUi/jbt04YZtj0iQfm9OFVenwRmb/Q4LVbOwPwkL4z7bf5Syk4NmEw03nX0ZXiS+Ydt07+ETjq1anGXc0CVjLgeafKWnvW/3bhpmVdXVqJzjoonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dcyh9iU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601B3C4CED4;
	Wed, 27 Nov 2024 22:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732748356;
	bh=7q+HprYzzC+BJkpdZIdCVuKvfPuexWA6NfRf5oftI5Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Dcyh9iU9Tcn3yTsQipZSQ1qbmp50FoLdknJ+CGLUzye9qraVS36DdbwP9nDJ0njdq
	 e7TIFuf4TyGHkPc6BOZAA8rqUwOWhqINZ7W8MLzFJ1k1xZ0H+AGN6fHkwRelqIpzvF
	 Ud670qjTeGh2SLWV7D6ujTUyIw7IG7sL4WkJ5qxZEtsVMK8B1Bjw4RLRAjTVc7K09r
	 N7JeAsrDFhcFUD5P1uAOu/9t0a2FnQ8//Xs5lkGYOsmWjncyk6mZi/tad6pxIcwj24
	 bSo0mqDPDUVJkhZt3DBdrFxF5t91fgRuEJa3loV8n77xSU1NHGYfpTslBNTBKllUKo
	 dcgNb9lAw276g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC43380A944;
	Wed, 27 Nov 2024 22:59:30 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jH9yWHEymTNjWTw2h5Vgh4yXjjcYFjpmeRi8kskOwxuA@mail.gmail.com>
References: <CAJZ5v0jH9yWHEymTNjWTw2h5Vgh4yXjjcYFjpmeRi8kskOwxuA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jH9yWHEymTNjWTw2h5Vgh4yXjjcYFjpmeRi8kskOwxuA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc1-2
X-PR-Tracked-Commit-Id: 6f683c7feea45cbcd8748aafe73b0c79a6909e26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b86545e02e8c22fb89218f29d381fa8e8b91d815
Message-Id: <173274836916.1238022.12364580809618726378.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 22:59:29 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 19:37:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b86545e02e8c22fb89218f29d381fa8e8b91d815

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

