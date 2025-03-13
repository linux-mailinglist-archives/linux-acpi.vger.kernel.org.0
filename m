Return-Path: <linux-acpi+bounces-12159-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE04A5EA70
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 05:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780F93A7300
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 04:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02059136347;
	Thu, 13 Mar 2025 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="l8mbPoKT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="15ku1EtE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C9D86338
	for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2025 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839147; cv=none; b=p52B+pUuNhCPF6ln+r3RchD7jf6EeSA528Jilo+8CcTRtDptXIdn37E2z6mQUjzDAtfYt4qTi9iXx8IHQWkdRK/c3llSndY4nUKbnl06j+trcg34a2ahyolmnKfptTznvafa5Bx4/IrX+xO3VY+F3nDGr8nXEg1eO75pYYiOwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839147; c=relaxed/simple;
	bh=7n7LbmcRMwrveBvwSSJO1k4Y2E34ZXs/wsZhqgFXdnw=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=VmjJCfsKN9yiDvYwEdAaD0Lwm6nz/gx/oihJAJlhkxXUgP4gE5Oj+bebOZVqi64YYzCgUAlGBsmQF9nabJl8OKV74e9syiqSa+2NMLgY47ClGMe8zPAqjTU98/QCTMghhrMozQT0YygctSMNLQhnm9zSj/kQY7TKFHj6YVSBrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=l8mbPoKT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=15ku1EtE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55AF21140226
	for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2025 00:12:25 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-11.internal (MEProxy); Thu, 13 Mar 2025 00:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1741839145; x=1741925545; bh=53g02nreqV0TLM8fGt0dydzLaNtKp4BiO1l
	IhZzRi20=; b=l8mbPoKT2oXjVpFnGZWZL4E53DhRylEUUuTlGpho6PiSSyqYkTR
	jcuZqO3Qjkt/4Ia1GLiDzsGuT0upfQzlOzBsbi8htYtckCtcizA4c95IslvLl5t9
	zkxZU4ynKxXOBIFngrukJvRee+7Sd1bHJUg1NTEbbSgyrFGbJ2pkCozZ1sW77T9F
	iHNsIt+BHn56p1xf1H1mefpXxwx3lFRm3eJhu3XyWCAsLvjes2n7OFET2RU+7vNW
	0GTZLm8lg1bWzbEdcEvSWe6nWrRjfoJfo3LmJQJXNx5zd0AsoiVo7lwQf4IEA5iR
	1oIgEcKKe0vJ1RPiREvZboA+qhvCO5Dz16w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741839145; x=1741925545; bh=53g02nreqV0TLM8fGt0dydzLaNtKp4BiO1l
	IhZzRi20=; b=15ku1EtEVYdOT+HPIcBwkAWEEDNLZFj4FO3wtAxNeNp83WcoAX9
	ID/y63bNYvbmWqubFMJAS3U7W2E6Tlyn7QVBGggIZ96ufNCvRCQXbjeA4vu8MwsW
	KYG/rV85ztEvo5BqnIoSqVCOwb1WlqXuTpvs5SUxuaEzwP27jWtBcyrAGwnl3K6+
	4/oreIrL01M3h4pAR9RPm2/SkQclblLME549PprX8ZzrkybQLG3r8n3raPfDjLFw
	aNJcwzbCh1CU/r3EodA72m+24G5Sc7/sa/NR5a5lYjUjSBhuL83Gstmt43r+o+tN
	AE05ffsskQ1lbtF/1CkT9AEn7P6SRJjZOhQ==
X-ME-Sender: <xms:KVvSZxK8p0MLkTV-HM6KW0q-xUCLOjLzBtKN9C8729GEm08oIJd19g>
    <xme:KVvSZ9Jb8cVCnGfTprYx4UrARAUJm9ARkonXrTKwwluqoBs-ZnU8WB8tcFGXbY6Ec
    3MQQ5UfpYQ_-H5pEFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeileeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefogg
    ffhffvkffutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhih
    fdcuoegthhhrihhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtth
    gvrhhnpeelfeeuudeiieffveejteefleefjeehvdefvedtfeevgedvtdeiueehfeejvdfg
    hfenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheptghhrhhishestgholhhorhhrvghmvgguihgv
    shdrtghomhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KVvSZ5scO9m_J6ElcGC__J5TSb6ArrYESb4SacqRrqMlQaMTh7dQrg>
    <xmx:KVvSZybcpaeQR5YASS4tQQvwPOcqalMaYCr7fPpKeKjR-AOnSreqVg>
    <xmx:KVvSZ4aktIhv6QOkoThmv9e1anoI6KQUxbuKKOlcc4KiPnX0X2XkWg>
    <xmx:KVvSZ2ANKeFySFZedJBLK9lKX72vFPD8EH5-g2IXFC7SSYnR9tvKzw>
    <xmx:KVvSZxASF0du4d6o9lJtb5IEaFLapxtcmG0jC2sj-hwLAaos7fp4vJKT>
Feedback-ID: i07814636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 132541C20066; Thu, 13 Mar 2025 00:12:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Mar 2025 22:12:03 -0600
From: "Chris Murphy" <chris@colorremedies.com>
To: linux-acpi@vger.kernel.org
Message-Id: <90e6da7b-a2b2-4ff3-bb04-f39b1f6c5e70@app.fastmail.com>
Subject: 6.14.0-rc debug kernel is slow, kacpi_notify high cpu usage
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Four kacpi_notify kernel threads are continuously using CPU, makes the laptop warm, fans run continuosly. This is a Fedora debug kernel, it's not intended for production. But I'm wondering if this performance hit is expected and if it's worth it (for kernel developers).

PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                                                                                                                         
  19429 root      20   0       0      0      0 D  26.5   0.0   3:01.99 kworker/4:3+kacpi_notify                                                                                                                                        
  21018 root      20   0       0      0      0 R  26.1   0.0   2:59.99 kworker/4:4+kacpi_notify                                                                                                                                        
  19753 root      20   0       0      0      0 R  24.5   0.0   3:28.92 kworker/4:0+kacpi_notify                                                                                                                                        
  21919 root      20   0       0      0      0 D  21.9   0.0   1:06.62 kworker/4:1+kacpi_notify                                                                                                                                        
  21206 root      20   0   38052   8192   3312 R   3.6   0.1   0:38.19 (udev-worker)         

A possible hint is in dmesg


[  874.399128] kernel: workqueue: acpi_os_execute_deferred hogged CPU for >13333us 1027 times, consider switching to WQ_UNBOUND
[  960.050165] kernel: workqueue: delayed_fput hogged CPU for >13333us 259 times, consider switching to WQ_UNBOUND
[ 1678.780253] kernel: workqueue: acpi_ec_event_processor hogged CPU for >13333us 35 times, consider switching to WQ_UNBOUND    

Full dmesg and kernel config attached to the downstream bug report:
https://bugzilla.redhat.com/show_bug.cgi?id=2351405

Thanks,


--
Chris Murphy

