Return-Path: <linux-acpi+bounces-8989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A39B0CB7
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 20:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1CB281082
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 18:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252BE20BB32;
	Fri, 25 Oct 2024 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzAyE5d0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0D20BB24;
	Fri, 25 Oct 2024 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879821; cv=none; b=RLHX6O+P5Z7ya7drgvgNNAj7/odhSRIlEivHJ5BuyT79VIXMFqoBuK9qXDFgq6LV1i5jGMYLHbq44a73oH3Gh9Drfc0LIicAriqOXLVS4lpyvGeuZfYECLjd68u9KzfpY2inXNWo6xH1SmW6Sukvr7I9UEQXjXO3mwc5nI1vA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879821; c=relaxed/simple;
	bh=5JxQKtIl36dELku2Uiayw6fN/M51G1G7BXqU9g6hC/4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=szLQSG6Fzx9j+8CyCY2DN5FwugHF0uA+OGlDv5akN15sxSUy3EdigpDZLUknEQwQK9Hdot1pdJHllSY6aAe3XWEUHwHK6V+8DwVKW6gPs1scB5oJ0vVlj+P8ciDoDcrLY7kOZLT6dbumD11WbE2wH7JBJ236Zmb4QFOgIEPBYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzAyE5d0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB5CC4CEC3;
	Fri, 25 Oct 2024 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729879820;
	bh=5JxQKtIl36dELku2Uiayw6fN/M51G1G7BXqU9g6hC/4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jzAyE5d08Efxl7oIwO7XlDT8hG8nf/mnVVO9Sxvn2B5jQaCnQRyDhIVvINrapxKlE
	 Dv6k9v0RuNT7cEk3J50LxJsWoa5f75yTwjsZFrW3D+uVqSkoBIUOTPDiQ9CbXvwW8w
	 O1tCxSvqtGEYMJvteOOecOhjJPoqAISWiW1XhVoG6yIVTzDbnUY8dXSi8JXxvp5Km9
	 cx1kLr6JlDCEhc/xZrfYq3MoXaWQkyoichk5NgLeIncih6WG8vGibY6GC9Ew+yQn+u
	 5lvrggVrxc7KlQkXGFzl8KcP3B64KFUYXmjCVDT/2xt1PjkHY2ryfxVORsQRNG8qzL
	 YtJag5E4+6+YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72B833809A8A;
	Fri, 25 Oct 2024 18:10:28 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g9kJzKXGjF-q+r8NDTqYoDaa8J1cyOj=TRN-GMMHqiOg@mail.gmail.com>
References: <CAJZ5v0g9kJzKXGjF-q+r8NDTqYoDaa8J1cyOj=TRN-GMMHqiOg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g9kJzKXGjF-q+r8NDTqYoDaa8J1cyOj=TRN-GMMHqiOg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc5
X-PR-Tracked-Commit-Id: 1646a3f2b1bda03a763f7aecf83504144fb8bba9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c76163fff18f2149f923e1b3c34d00801668244
Message-Id: <172987982728.2993589.9547486725938026373.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 18:10:27 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Oct 2024 17:50:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c76163fff18f2149f923e1b3c34d00801668244

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

