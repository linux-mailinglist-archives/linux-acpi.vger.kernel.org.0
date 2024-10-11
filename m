Return-Path: <linux-acpi+bounces-8710-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CEA99A09C
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 12:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D65D1F24141
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7420C493;
	Fri, 11 Oct 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RAaQ2SC8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QEIRZFB2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F8819DFAB;
	Fri, 11 Oct 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640811; cv=none; b=XHbNi/cK27EpN/OZupaIHC2znZxdVHameymYl0IitBSvDKNGKtR28V6Q5MnKXqoEi/G6xk70r/XF/sd7g2rN/wOvehwn0/yb2budydwxq1Y32wA+wsgiRa5Mh/wcS8r91tRCY/Di5g2SpibdaW7yp7jS3iurWh08ySt4/oHoqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640811; c=relaxed/simple;
	bh=ZpF0xQ05tkLqTlOyBDcw4AoSMq7o3KezyfCI13T1M/o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U09frsYGKfkACL2yoEhsB6Z9l9OhPCC12dt7060SeKA9zSW/VS7mtHTVrk/f3CAQYRUUiO0drznSEgH75Gj+nIXI3CSNU3sQ/YbdfycXKeghxZ+BIgdmh7AAe2/6BGR9SAohz1bbGlQ61VprqMCi/y5sFOxbcvrStstfiUUVDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RAaQ2SC8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QEIRZFB2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 734DD13801A7;
	Fri, 11 Oct 2024 06:00:07 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 11 Oct 2024 06:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728640807;
	 x=1728727207; bh=+HfamdzghNLbAgFrpKdfwQHqTtsV9TeaWTuLB2b3cCA=; b=
	RAaQ2SC8uu+9Q9YQiZlsiDUsVPMJBggTupPyyMk2ydV7E49DfgViNEP4DQP/F3zL
	ZTO0wbE/2qmRasDOowvvKfoJOjvlKHz8eSHy73KkCaAY+BNkRRUbkTIhs1HeuOj7
	4iGG7Yij4J7FV85HDcVUE00oM+dfBF7h5pu1703QxnvTWKTbSU+kHBHikLcOyWdV
	FLP9wG2Ea+M7+2jgHxqp2tfO54uESBsRNbRdKb24m+XfD8JYiRKWBba/TuYcIj82
	xM/Y+Anl9h0h8vg3PPqKzFj8lmh2ri//Ayy08JZYqdLDXerb7hLILlf/ob0lJIJr
	KqcxxH/HlhJMS/s6zYkDvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728640807; x=
	1728727207; bh=+HfamdzghNLbAgFrpKdfwQHqTtsV9TeaWTuLB2b3cCA=; b=Q
	EIRZFB2WN/Q+gd+oqITAsNuV+w4/ykSX5+Tw6kZZBQfbac5NaVmYoo7aE/BVW1mz
	Hlu0FDZjqvU83RwarGLb258QeTLRbxbAYnSoTsBcEjmvHdS5lR0A7pppRYJFMp9R
	QjnaCo2fhac6TKmo4nWKvzGHBAMpJM8m8/clUXBPgX5oFZko7wT0zUSozbjVWLq/
	cSSXVoRlE4CJjZKqsHLu8wWBwaAyqZyJbJiCQfwLICCGXqe+YE6a1wWuCoZSXigo
	gWzfg+NPkiYLHV7Fgig+IMfbQ7mQWRAmxaGA2HuY3Lu3gTX2qQJkx4KiS3rqqmbh
	LUcGf/omyYS6dI2SRRG5Q==
X-ME-Sender: <xms:J_cIZ9YiVZeBc34OMhYO-JZfji1VtJ6e7-IQx55O886Nk1sNHiVSQA>
    <xme:J_cIZ0Y1yuXXeKIXgd2mJjCS1Fdqvyp_vacl9UPD3HjWX1HPPKVK9qDhNJGcm6d4J
    ebX3KIN43VFuwkJxzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrihhordhlihhmohhntghivg
    hllhhosegrmhgurdgtohhmpdhrtghpthhtohepphgvrhhrhidrhihurghnsegrmhgurdgt
    ohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvg
    hnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrd
    hinhhtvghlrdgtohhmpdhrtghpthhtohepvggrhhgrrhhihhgrsehlihhnuhigrdhmihgt
    rhhoshhofhhtrdgtohhmpdhrtghpthhtohepjhgrrhhrvggufihhihhtvgeslhhinhhugi
    drmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J_cIZ__q3Uq9zKvBtiTk0PhxoqUVB7MIvBQtSvn627t-b6cl0YVgew>
    <xmx:J_cIZ7qUlUvYkTfw5UaKcKlzyn9Hzfqlj3mq0nHN64zyrzWydFB69A>
    <xmx:J_cIZ4ozCzYe1mbEnX7Gz4Bi-tCFKsshUtzSqKteZdL3NatwKQAKXg>
    <xmx:J_cIZxSKMcOjIJVyrQEnY-ty27ASk-OPtmAhcgmvTPeFKASL7fpE6w>
    <xmx:J_cIZ_1XgZ3QhwvNXLGM4sDvZ7h6w1h6JwJfNOA7PQ4cqicxBGVd8Ao5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1FA9F2220071; Fri, 11 Oct 2024 06:00:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 09:59:46 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 "Jarred White" <jarredwhite@linux.microsoft.com>,
 "Perry Yuan" <perry.yuan@amd.com>,
 "Easwar Hariharan" <eahariha@linux.microsoft.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <de65a5c8-1bbd-47b3-9dc5-de4ad93c41b8@app.fastmail.com>
In-Reply-To: <Zwj1p3uMEA24a0sU@smile.fi.intel.com>
References: <20241011061948.3211423-1-arnd@kernel.org>
 <20241011061948.3211423-2-arnd@kernel.org>
 <Zwj1p3uMEA24a0sU@smile.fi.intel.com>
Subject: Re: [PATCH v2 2/3] acpi: allow building without CONFIG_HAS_IOPORT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 11, 2024, at 09:53, Andy Shevchenko wrote:
> On Fri, Oct 11, 2024 at 06:18:18AM +0000, Arnd Bergmann wrote:
>
> ...
>
>> +	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
>> +		*value = BIT_MASK(width);
>> +		return AE_NOT_IMPLEMENTED;
>
> Perhaps it has already been discussed, but why do we need to file value with
> semi-garbage when we know it's invalid anyway?

It's not strictly necessary, just precaution for possible callers
that use the resulting data without checking the error code.

The all-ones data is what an x86 PC would see when an I/O
port is read that is not connected to any device.

     Arnd

