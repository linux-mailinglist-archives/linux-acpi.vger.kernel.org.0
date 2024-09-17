Return-Path: <linux-acpi+bounces-8323-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBB297B54C
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Sep 2024 23:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14470282225
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Sep 2024 21:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F072D18D629;
	Tue, 17 Sep 2024 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruhr-uni-bochum.de header.i=@ruhr-uni-bochum.de header.b="BJYBVQue"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out1.mail.ruhr-uni-bochum.de (out1.mail.ruhr-uni-bochum.de [134.147.53.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB241531C5
	for <linux-acpi@vger.kernel.org>; Tue, 17 Sep 2024 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.147.53.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608995; cv=none; b=QB3nbfQJrQ8UrNy+JqBicnfxVstr/mIz8aUsDUq4WT7i5ZuTSexgQsxHyF9f+1LMqQlUYFMhxjcqos7R7qk3dZ4SWwTcEoUTmnyY2MFa5FKhDwStvfRjVnVahTPOph8wglyChW5mDiiXvoAAfXAoIZtrLSfgiUPahk/1ebIeUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608995; c=relaxed/simple;
	bh=MnQdG0cw3WNE2DTkoF5pTlUjT9rnpLJglvirsfeafRA=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=cR+zSiu7wqqEggJBNp9A98Xk+xcsCe4zLM10Cjdt9euC1iSawavxDQ7/3XVjzvwFVKE4MFRy3HXNQ0HN171XASTefTigqDW4E14a3xxN5OV5rtHJz9lmjBlQ/9PIN2nBYCwwMEe4OZLM+cWfpz40DTXiINGZPSbg0RTy73rF9aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruhr-uni-bochum.de; spf=pass smtp.mailfrom=ruhr-uni-bochum.de; dkim=pass (1024-bit key) header.d=ruhr-uni-bochum.de header.i=@ruhr-uni-bochum.de header.b=BJYBVQue; arc=none smtp.client-ip=134.147.53.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruhr-uni-bochum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruhr-uni-bochum.de
Received: from mx1.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
	by out1.mail.ruhr-uni-bochum.de (Postfix mo-ext) with ESMTP id 4X7ZdP5CPpz8SxF
	for <linux-acpi@vger.kernel.org>; Tue, 17 Sep 2024 23:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ruhr-uni-bochum.de;
	s=mail-2017; t=1726608489;
	bh=MnQdG0cw3WNE2DTkoF5pTlUjT9rnpLJglvirsfeafRA=;
	h=Date:From:To:Subject:From;
	b=BJYBVQueNdzurqVZH9qTOopXjDQENEJlP6D2LWntFKem1n9CzxJIgjjHmGhsptf7Z
	 3IfUHBo7Vh+ZhaZMOPre6sNrV1pZ/JaPk+Zjv/qoXImpQrGPh19EtcgIipvGTtsB1I
	 8wXaBm0Pv8TnRQZclwa4XriUIutnpJFQBwgOlcJA=
Received: from out1.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
	by mx1.mail.ruhr-uni-bochum.de (Postfix idis) with ESMTP id 4X7ZdP4Q5fz8SvB
	for <linux-acpi@vger.kernel.org>; Tue, 17 Sep 2024 23:28:09 +0200 (CEST)
X-RUB-Notes: Internal origin=IPv6:2a05:3e00:c:1001::8693:2aec
X-Envelope-Sender: <David.Renz@ruhr-uni-bochum.de>
Received: from mail2.mail.ruhr-uni-bochum.de (mail2.mail.ruhr-uni-bochum.de [IPv6:2a05:3e00:c:1001::8693:2aec])
	by out1.mail.ruhr-uni-bochum.de (Postfix mi-int) with ESMTPS id 4X7ZdP2j6bz8Sw9
	for <linux-acpi@vger.kernel.org>; Tue, 17 Sep 2024 23:28:09 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.6 at mx1.mail.ruhr-uni-bochum.de
Received: from webmail1.mail.ruhr-uni-bochum.de (webmail1.mail.ruhr-uni-bochum.de [IPv6:2a05:3e00:c:1001::8693:2aea])
	by mail2.mail.ruhr-uni-bochum.de (Postfix) with ESMTPSA id 4X7ZdP0J00zDgyj
	for <linux-acpi@vger.kernel.org>; Tue, 17 Sep 2024 23:28:09 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.2.1 at mail2.mail.ruhr-uni-bochum.de
Received: from 2a00:6020:409a:2f00:3ad5:7aff:fea6:38f9
 by webmail1.mail.ruhr-uni-bochum.de
 with HTTP (HTTP/1.1 POST); Tue, 17 Sep 2024 23:28:08 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 23:28:08 +0200
From: David Renz <David.Renz@ruhr-uni-bochum.de>
To: linux-acpi@vger.kernel.org
Subject: Testing and profiling ACPI code in a Cuckoo Sandbox
User-Agent: RUB Webmail/1.6.8 via Mozilla/5.0 (X11; Linux x86_64; rv:130.0)
 Gecko/20100101 Firefox/130.0
Message-ID: <40360caa659c02f5c423639862f9e210@ruhr-uni-bochum.de>
X-Sender: David.Renz@ruhr-uni-bochum.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello,

did anyone of you ever set up a Cuckoo Sandbox running Linux and used it 
to test how the execution of the ACPI code affects the system?

A few years ago malwr.com was hosting a Cuckoo Sandbox running Windows 
where you could upload any executable, let it run and then get a very 
detailled overview how running the executable affected the virtual 
Windows system, e. g. what changed were made in the registry, deployment 
of files and internet connections.

I think it should be possible to set up a Cuckoo Sandbox which uses QEMU 
to run Linux and to provide specific ACPI tables when doing so. I just 
don't know how well it works, so I was curious if anyone of you has 
experiences with this.

This won't apply to any of you developers of course, but it is just a 
fact that any hacker could use modified ACPI as a means to compromise a 
system, if he manages it to write the modified code to the tables. And 
the execution of ACPI code during a Linux boot can't be avoided, so 
basically this is a quite important issue/aspect, which shouldn't be 
simply disregarded. E. g. an attacker needs only be able to hide the 
calling of malicious code which is located at another memory area, and 
then you're doomed, considering the privileges which the ACPI code has 
while it is executed in kernel space.


Kind regards and thanks in advance

David

