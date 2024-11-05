Return-Path: <linux-acpi+bounces-9334-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9182A9BD9A2
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 00:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9221F2402C
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 23:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F52F216A25;
	Tue,  5 Nov 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zplane.com header.i=@zplane.com header.b="MgZHKrAt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bf4dl608"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4B216458
	for <linux-acpi@vger.kernel.org>; Tue,  5 Nov 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848842; cv=none; b=tX0HcNNUrXvzcvufOxAMfU8QN04H3kxlUeJ6W9WvGe54x75dkfj2HwsChJWvu0Er1rBXSmdRNGAdqAWZ9BsF7S5zBav402RXCSi9UcOmYE5gYiztxSTQKWR5QPik1fZ1ooe0i4aLv4GiaTjFN+KG6d2kCv2raFlPTlHK+WYOdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848842; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rI+RNND7LQ0YjOaxnJJJ7yM9YidIZoVg586dpHusR7USTZnvKbYlMdv486N1zTi03puziFAiRqJ1Qs2T6OodsZDIeJFcenLnrhaoB5fplNY7DTowTx2fZPxBUd/tHWSISbFzmRvjBX4xUlqPUaqkxIpwi7zm00u9cKRj+tb+qD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zplane.com; spf=pass smtp.mailfrom=zplane.com; dkim=pass (2048-bit key) header.d=zplane.com header.i=@zplane.com header.b=MgZHKrAt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bf4dl608; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zplane.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zplane.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id BFBA51380459
	for <linux-acpi@vger.kernel.org>; Tue,  5 Nov 2024 18:20:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 05 Nov 2024 18:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zplane.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:reply-to:subject:subject:to
	:to; s=fm2; t=1730848838; x=1730935238; bh=47DEQpj8HBSa+/TImW+5J
	CeuQeRkm5NMpJWZG3hSuFU=; b=MgZHKrAtPbGcmrtpfmJA87ibX4dw0a8SmoBxV
	LP6FKCmfsL1hsjqj0RSpWwQahNz83UqKp8N9PHdyI+zvusy9ItejNw8P2pghffue
	FsWgq61fIfLQfEaICbA0VOSX1/fr1CQ4QaCQ75YGWMwGth2mVdfmHPX69dv4Wv7v
	UwoHX7AuqlfB18zCtoVP8uqq/JwM+UvjPK6tT0O8KdizqzSakM/Ceh6+XQh2K/mS
	SJ9m/40o6mrJJNSc23kv3SySkHjaVj2zbs291WIQDYfRj4/XZcFWqMUrUrLqDAX+
	NYYU16i7utkYC7WHscKtBjl56LIw+poxAzsQTjt2A3WwcRmNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730848838; x=
	1730935238; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=B
	f4dl608H0lyvvvBYrTOYEiX7gxJJtY9Xq2tKZkmt6xFSQVGl1JUtHLmPlamYRxYp
	bRtnj8u1QGr2/AAxJo91Z0/rokbk+gNeYFyeyQFOYRb9fi8AYpHqXwXKB/hCvcuY
	4ImfBWlloStxM+HYTM9opbQNxfbqwFbLoip/R/djDP8u1b7sF2TUfUmloirPJxqw
	f3y84sY2bLzFra4teQQi4BOHs+PqqkWUDUvW6qpAPyO7GeeyigRsIVNe88aDqafi
	xgQXUmMKEor5pRJ0GTRmCPCt10Yt5+Moy95glzMrU7OGL1GvOp/elKJh9mmcMlqq
	HKRJLNU+2xYDC06jwGAWw==
X-ME-Sender: <xms:RqgqZ04w_t8-ebkqDfuJ_eoxGk-dmFx-7YXEPRPIhoPxb6E-Pd8UeQ>
    <xme:RqgqZ17BfjIBaOkJZSKulWLN90YwR9FB1vB_G9aS0PYMcEB3P27s-24eZzcR-boSS
    GjG4zLshHH1ubLH>
X-ME-Received: <xmr:RqgqZzchux-mXCmW5-Tkr9ifRR67LzdhOVZzUTE1OftDCmy0qx9LKixFgWnGVZZKzoN1TRV8RKGBI6GT-zCW5DzOq_Oby-E35WhmXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecugfhmphhthicusghougihuc
    dlhedtmdenucfjughrpeffhffvuffkrhggtggusehttdertddttddvnecuhfhrohhmpefi
    lhgvnhhnucfiohhluggvnhcuoehgughgseiiphhlrghnvgdrtghomheqnecuggftrfgrth
    htvghrnheptdejvdehheefudefhffhjeduhfegtdeigeehgeeuffdtgfehgfegueevkedt
    tdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    gughesiihplhgrnhgvrdgtohhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:RqgqZ5L6GzgZQL7dSMWCa0eaCmWv1p6xfbhMAGqAsa1hRy40TuUDBg>
    <xmx:RqgqZ4Kg5N2ZcYYANRpdjsecJtyc0aUpcVPXYUgbpWtmiiglRamfkQ>
    <xmx:RqgqZ6y_Sxe4SKEzOUXOTpdS9pYresDsD7_ippGMkJ96TSv9WxOAeA>
    <xmx:RqgqZ8K1okaMuDkuB_6QpO2hiRcsLodDNbFOz2sDD-GSV7otxQc3BA>
    <xmx:RqgqZygGrZypOqPOyIzlbIkMS_XCXIGrV8vkuxVqvxXm75LK-aypKk1U>
Feedback-ID: i002c41f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-acpi@vger.kernel.org>; Tue, 5 Nov 2024 18:20:38 -0500 (EST)
Received: by gc.zplane.com (Postfix, from userid 501)
	id DC43A4012A; Tue, 05 Nov 2024 16:20:36 -0700 (MST)
Date: Tue, 5 Nov 2024 16:20:36 -0700
From: Glenn Golden <gdg@zplane.com>
To: linux-acpi@vger.kernel.org
Subject: Unsubscribe
Message-ID: <ZyqoRFNbw2ZbAhfC@huh.zplane.com>
Reply-To: gdg@zplane.com
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



