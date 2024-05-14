Return-Path: <linux-acpi+bounces-5808-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66F48C5CD7
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 23:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810E4280EC6
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E777181D03;
	Tue, 14 May 2024 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHZK/Hwl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326FA181CF4;
	Tue, 14 May 2024 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722226; cv=none; b=ZC3StUuzaKSc7xnhphVAOtMADUNG9E8bb9TW08BaPtd1hrt7Uy8t1RJCwgbdTKYPh5s+RHph6bCzqyK3WhsIuXvYQaUK6fh5JpXvgG3w9Ley13O+5M2ANLD79iAY9CmX20zvZODQ+Mh1roaym+5EOfUHdoA3AYEr+vulQ8/OeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722226; c=relaxed/simple;
	bh=VaL8nFiczpgfRJMQ3pv8cT6KlJb4XCkuMxz7HK4MrbQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dqvcopS8TM6hEABifRhsag//EdvPUbESGItvdfr1YYDg8nCnkCtdOzXJrrnW/0UlVprUb2GXYBnfTcFER9cD0VDbXVTJMxc1/DItjLiLGl6Ksr0nN2ykdl6OBQWVRkiuV3oh42IlZbHY9TS5pwiGH9avuVO97DiI/SXWHdztCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHZK/Hwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A36CC2BD10;
	Tue, 14 May 2024 21:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715722226;
	bh=VaL8nFiczpgfRJMQ3pv8cT6KlJb4XCkuMxz7HK4MrbQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pHZK/HwlN8D7EBWHzpLoZ8NCJemEREw4wTblKa+6+0Uf3QTlWNGYmLhDaYrGUtD4D
	 y1TEtNYkklwqVfMGra74RPW6VhgcJUjBN9BvMt54dW1ZKfeERJmMQR5YXuIthgYv46
	 fS9wDdwCL7to0OQTZ9/SE7Nx5Eu7rpUD18OHgCPa2FWDe1NTuHI/9dlAqiQ7J9JuPI
	 XgzIIHbiw+dJeJz2BhB3kX0M7eo80+ARVpfhEz2bkODOlNxAsFuc/vVNkPLtbiu32i
	 52Dl2nje7EhLDShNKy08Wpfba8dmufBc2J1DR5wmz/w9aqmdvDMfE0fpVQbQztz48z
	 ncIPzMn5Lue8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E64A5C433A2;
	Tue, 14 May 2024 21:30:25 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iTaVs5EBUkq0Vs39y+gYCcsZypW5YJNS1n3ES+upM2JQ@mail.gmail.com>
References: <CAJZ5v0iTaVs5EBUkq0Vs39y+gYCcsZypW5YJNS1n3ES+upM2JQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iTaVs5EBUkq0Vs39y+gYCcsZypW5YJNS1n3ES+upM2JQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc1
X-PR-Tracked-Commit-Id: e573d27e18f8289454b6abb378de531374bd3cde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 101b7a97143a018b38b1f7516920a7d7d23d1745
Message-Id: <171572222593.832.7300894485575755490.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 21:30:25 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 21:30:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/101b7a97143a018b38b1f7516920a7d7d23d1745

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

