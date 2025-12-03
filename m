Return-Path: <linux-acpi+bounces-19394-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD435C9D88D
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 02:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF133A19FF
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 01:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08162255E34;
	Wed,  3 Dec 2025 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYhnjsRw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3D254B1F;
	Wed,  3 Dec 2025 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726795; cv=none; b=RMiuTVHCg0wNhe4He4s0JSE37wOM5k1vFJNgxL7Ql8/SycCQTO7CT7dya74xeoxxNdyNDXhdC1gUqlJFL9LMWb7/eNIjETSfRYaPFKbUmxY2dGrZIKDIFNnOYZGEVBXxyhZzqb0iZWG7uvznGNCJiU7WuoWHlUl2tT9UduJLj2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726795; c=relaxed/simple;
	bh=F1ywm+7Pp60PSQj57Tu/9lw8YLlk8yONgZAnMszerNQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BqyytCXWYMI/6cZ2g14cgCev5WcogvtoIJp+DSWC+s/NAeovxLx6SMBPEVJl+zCmxz1ya5vqeIGn8qYA7DEQ5w4hqUI+XYuqsv45BT4QmHjO9KLfShUwTld9TDIHMI/ikkafsTAMkAP6kYDDZdE5lJqSrsuKHry2XLt7s1JVtpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYhnjsRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35B0C116B1;
	Wed,  3 Dec 2025 01:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764726795;
	bh=F1ywm+7Pp60PSQj57Tu/9lw8YLlk8yONgZAnMszerNQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nYhnjsRwGOyY7AhmUP8g4dvk6n+LNHqqv9s6e1vGkSlyGVImnyeqqOOPqNWax/0T+
	 c61tMC4P3N1mgpxdqEQKbQ82L5wXVa24AH6ldIzAClbV73KG1wsBQ7kmZxsi4+QhoC
	 zo+WwMw67IO7v4vebakYxoSrbO4AHsArgnB7n2TfjKkxH2XNxjs6ydhRrdWO4P3Xiy
	 qWOU5SOQ469BsODRB7f8Hjut0l/W0DjvMy6EMJkh/sVWGPxrOkBhdviVM+yj6XiCX0
	 S6l7M1eYsGoO8iKnzkJg3RitjO71lTIZrrqsiWSEHeHpynv25wN05db5mwMti06slw
	 rTXQ8N42NpeoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B64B3A78B36;
	Wed,  3 Dec 2025 01:50:16 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iDwQTbmwxSNTrHsoHmANMzd6MzWgAXRNxnfhE00wUj+g@mail.gmail.com>
References: <CAJZ5v0iDwQTbmwxSNTrHsoHmANMzd6MzWgAXRNxnfhE00wUj+g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iDwQTbmwxSNTrHsoHmANMzd6MzWgAXRNxnfhE00wUj+g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.19-rc1
X-PR-Tracked-Commit-Id: 63d26c3811421ceeb5b82a85489b88bf545e33c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 619f4edc8d4f785dcabf564786e787fa8108deb4
Message-Id: <176472661518.3473163.1044741912244589651.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 01:50:15 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 21:35:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/619f4edc8d4f785dcabf564786e787fa8108deb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

