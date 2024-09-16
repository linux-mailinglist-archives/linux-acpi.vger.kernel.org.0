Return-Path: <linux-acpi+bounces-8313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB98C979AF7
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Sep 2024 08:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946091F2383E
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Sep 2024 06:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89FE13B2B6;
	Mon, 16 Sep 2024 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZiMjzSs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA312D766;
	Mon, 16 Sep 2024 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467136; cv=none; b=R8xPOwHNn1yE2PKrDlKKs0W7lEWpgCenIrV2OGnXnA8aKXLSy/Dmvq1eRdhFcjd5NTHFEsRynCvEjKyNgFYC/oJ2+rd7jVUY+Z3cwJIl3z/HI1VtSC7QF4ZMaVU6T/eG62x4FANzPIjVdNzKFVIo3wSckhBikWbFvEVlofZ9d2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467136; c=relaxed/simple;
	bh=cTGh4h/hD8dYQcBa1fMSft2pDdIk5GHInR9ifKaW+8g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ixhqgwU59XqOEHZ+op5twpdqsEQvN1gcQuvxF9iPpMBmi7YP2LNxGPt59B1upfPXM1MSchopxCvu0FGbNBZhTd0gRQSEfTrg5PdKw4rL9f5LAFy0AUDexUGfHktrDgqHyPcPx8sAQ8JiJ1E/9ZMIJSzfT8Vxw5OsyBRDD3c8hPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZiMjzSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74189C4CEC5;
	Mon, 16 Sep 2024 06:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726467135;
	bh=cTGh4h/hD8dYQcBa1fMSft2pDdIk5GHInR9ifKaW+8g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dZiMjzSsj89Y4ATMrlqNiWnYtijnk6Afg0ac2QkepFeFIwUpB7lQ2VeuDEUjUJIZs
	 0mI4naNMDlXiU8ZZQFWaXMwCv7m0gcs9Xb96el63U0qJQs6iH/9tgn/amWQSNvmFy4
	 LnbLJM3/zUgioJxCa+J+g6tDxprDi2Vy8ZzStN5UsxAp7h0P46RYENBYy0jKb3P9KF
	 N5MePtapImB+L3rUBNXdRAMtMNEnf9JWtIuc/Ra6QoVf0KMJH2KoHiupA7/BSWKvaN
	 wxaSke9YOwT7ycjZ9RZWSO+vExtxm4dso5/JdrZ3CBiaOyoHcSfcBpyDecV0GUHKJW
	 IcDedanyhmfbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3456F3809A80;
	Mon, 16 Sep 2024 06:12:18 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h44icEbV3_WRxkv+q+z7hYgKqSCbJxRBddb=OahdPuzw@mail.gmail.com>
References: <CAJZ5v0h44icEbV3_WRxkv+q+z7hYgKqSCbJxRBddb=OahdPuzw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h44icEbV3_WRxkv+q+z7hYgKqSCbJxRBddb=OahdPuzw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc1
X-PR-Tracked-Commit-Id: 3dd2fcf496359d2e196acd33e53dc921d6e39cff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11b3125073d16929403d3aa7b2ae6a482060a937
Message-Id: <172646713707.3261404.12126404694964782746.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 06:12:17 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 20:12:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11b3125073d16929403d3aa7b2ae6a482060a937

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

