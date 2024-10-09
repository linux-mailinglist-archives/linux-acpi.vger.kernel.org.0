Return-Path: <linux-acpi+bounces-8672-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E3997530
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 20:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0581282C84
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04201E04B5;
	Wed,  9 Oct 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bigon.be header.i=@bigon.be header.b="obXCxebf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581013A244
	for <linux-acpi@vger.kernel.org>; Wed,  9 Oct 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500363; cv=none; b=NTbc5kvUKVIqBYLk7/H9iY4j/xiU7F0KgxiNbDrvdquyTovJj30zKrp6/eijIqKG+0aIiMsRgQNR7dhH9MPxpYGoSWpaHU989YwO7DkqMXdqlBc33Kkuu+DFKMn5P3vF5DJKnRE43xYizaZGAWO9ACzrsParpttBOzDNVKpgNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500363; c=relaxed/simple;
	bh=gTph27nHFtSnf2P/6Cg3En2EqJPqxsLqn91GHuV0prs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cEzCHO1zL3Hdpl/6R2lwUmckwePImWCK0fd4QqyhxURuYKNukLhw4gv01RPuV0NqLYXzH4K20mYsRtH1GmkRvhKRmXWTDL3LXrpjPDnok3oEquKc0cy/3Z0rYLY+BqQ5MfEGOO7pOPG2GuN7kQQ8snSgyv+FIiRUAHwDO5RaU+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bigon.be; spf=pass smtp.mailfrom=bigon.be; dkim=pass (2048-bit key) header.d=bigon.be header.i=@bigon.be header.b=obXCxebf; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bigon.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bigon.be
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XP2HL1zZTz9t1V
	for <linux-acpi@vger.kernel.org>; Wed,  9 Oct 2024 20:59:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bigon.be; s=MBO0001;
	t=1728500350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tWJODsel5UXyhNhJacVYrGEf7E190L56BL5mqLHEFQY=;
	b=obXCxebfufyAx4XIP7vUaYzxGpgQH/wKVJSJV/z3HLmoWbvdUWHczOOQGhhL6te9CMow9+
	/U4ISrVoQE6S9C1NCL2F1us4ZhRn6D8y+x8dXpV5tJqxjcX4g99IZz4rF3EtwbZMiXNbPi
	XhZXXI+ArGIedfs/yAMNHp4vU+Z0qT4dI/vVLQ8WVJ91Fuii13soUOI5Ew1JPZ7Hf5MQ6o
	DBKCcEtKtc9HnC7peQD+6uEM23C5GJpppMoHIpBjTdfIDdXLAWhXU/hTpkP+Bzz1upIzx5
	gtSbc8j6hNmCm7mkstP/QWdzI8xgok5ZN3Sbi3oGkxy679iG1K2i9Ndrzkd00A==
Message-ID: <c9e29dcb-acfb-40e1-a283-4cef9b60c5b5@bigon.be>
Date: Wed, 9 Oct 2024 20:59:08 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US, fr-BE, fr
To: linux-acpi@vger.kernel.org
From: Laurent Bigonville <bigon@bigon.be>
Subject: Dell Latitude 5530 battery drain in s2idle
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I've a Dell Latitude 5530 and it only supports s2idle.

If I let my laptop in suspend and unplugged the battery can drain 
completely overnight.

Searching a bit, I'm apparently not the only one if this issue.

Any idea what can be done to trouble shoot that?

$ cat /sys/power/mem_sleep
[s2idle]

Running debian unstable with kernel 6.11.2-1

Kind regards,

Laurent Bigonville


