Return-Path: <linux-acpi+bounces-17698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA32BCAB29
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 21:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 386A54F59DB
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 19:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9470261B95;
	Thu,  9 Oct 2025 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQRlecBR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5626159E;
	Thu,  9 Oct 2025 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038060; cv=none; b=WLqKIIz2tzi15vAwyKGuFCPw79vd4QgkAJU6OERzFCeLe/a3pLR9yPMvytT/cI+y2zYmAXSepFTjxH0M2c7M/kfe8YD2q85UjsktiLmo44zzC7uMtO2NEWyWkPH1eCnQEZRhu65nnV5rAtQA7w4qv1F9kMKGgyVwcssU7ZG2iEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038060; c=relaxed/simple;
	bh=Tp51SK1Bnq6NsOyH8IZ6wtxBO1hLhNNxRyxeKf+f7kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h5ywxEveqPvcuzfiKI0BSIs+4CAVOu1t/GEdAkbaOJyl9l1QTNPeoeFqL2F7aIpxWbSWCFHyNKaNAQhdMdOOrKj0WzJCm+pZ/2DO7ZAmdkmF/KVLzt+sFh7i7D1tS8JuG7qcRX4Su287ehVlqe0YrCK+Rq+pQ04Lr9gThnr9haM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQRlecBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608A2C4CEE7;
	Thu,  9 Oct 2025 19:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760038060;
	bh=Tp51SK1Bnq6NsOyH8IZ6wtxBO1hLhNNxRyxeKf+f7kk=;
	h=From:To:Cc:Subject:Date:From;
	b=UQRlecBRgIeyv2E/o++7BlqxggSA7AZdzKg+09miGcuxxfyevZe5nHC1n68gp3WwU
	 qzJrPNHlxWj8wWO7HFzrabKeHA5tvZblIuD4YC/uivIj5JaTPArZvpB8tVIWjETvsm
	 05cEt/mo0FEgIj7cvyKNhO7U4961Oac1ITpA1WRCIM8HwqfnOlo+d9g9Ug7a2yoBS9
	 0pxYeZ24NXUhS4OoX5KX2KFPFvexZo9UDpf8HJFZdWd2uhPlVy5Qkw6vnZBuvzr1zk
	 QOYJ/MUCO/eyw8xDVviVbZbauE35POwajiQloK0PIUnmomQcqCGOFy33K3+ZCrYW6E
	 bWC1i81d+kStw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1 0/3] ACPI: PM: s2idle: Tidy up the code and avoid invoking _DSM
 unnecessarily
Date: Thu, 09 Oct 2025 21:25:07 +0200
Message-ID: <4699399.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

There is an unused function related to s2idle on x86, so drop it (patch [1/3]).

Also, some callback functions used in struct platform_s2idle_ops on x86 can
be made static, so do that (patch [2/3]).

Finally, the evaluation of LPS0 _DSM Function 1 is useless overhead unless
printing PM debug messages has been enabled, so rearrange the code to only
evaluate it when the data produced by it will be used (patch [3/3]).

Please see changelogs of the individual patches for details.

Thanks!




