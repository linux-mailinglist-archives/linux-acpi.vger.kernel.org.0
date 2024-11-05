Return-Path: <linux-acpi+bounces-9332-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE29BD8FE
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 23:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355C81C2260D
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 22:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27A21642A;
	Tue,  5 Nov 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="VRXMZIhw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kwq900+F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC3A216452;
	Tue,  5 Nov 2024 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730846872; cv=none; b=NYdiDBzmyZmRzYQ38f9AoR1lnA/c9DTVJO/3D0sJ00Cko4d6KwkkgsuzS5dz+nKpMR8TGKtNgBt7Z9eMIJHxZipkkH7uDD16qR2rvL/nprKda4nq7pI6IOnGrbyOGmcZ2FyQ4XQ8w1xawpouVoyelOruLzSqMEJnvHtGV74PpSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730846872; c=relaxed/simple;
	bh=iihAQ/0XfqQbsuVCqT+9AN1HLBl/26QRQ1HxqkML6N8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bCvJxVmySZZa4w8ijEHtiUGGs+4BBqAF2DzkG8M9CU5hoDG0ZCZf145ZcH0jdirOptJ1eG0xFwCWgmxUDf9zyQv75zeARdY5ldglNdupDDt4lfYUDXaUM+UalvE9r3xOYJPz2mBUDrfvofVoMoTx+dUKDDVLYCKd/zPBry2crc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=VRXMZIhw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kwq900+F; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 116C71140101;
	Tue,  5 Nov 2024 17:47:48 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Tue, 05 Nov 2024 17:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730846867;
	 x=1730933267; bh=esmOeO6X/9K+eyjXtUhTaCxoQ7oYKW2J2hxdgEDXFK4=; b=
	VRXMZIhwFfYfcQwSW3Unfc3T/MquS3j1YV20lXker3XXuXi11Up5feS7fseMHrbd
	eaMh3YRby04WtWLi9Q6ULv+NDEplqAK9IF2bKDs5XPXWFzXd4UrzVJH+Ak5lzcIY
	jM1xjI52DHz4csVkHirql9B0C3Fx/jL6I92VnlXwCvGTNFMDIr4En3ThqLLm1MiX
	sn6hWwbQ0tyjfE/LSNDBLo2/pt6KKtIsjoX5IyXCgtTxEaHudqAgVbs0MKtBpxB+
	41qEmP+iFMYintghxRZbsGngUBGNFY+InmsEtkP/hQdD/Uk5IuEj76zT9zrscUUH
	vVg0oEBaSFE7y8rjL4+eOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730846867; x=
	1730933267; bh=esmOeO6X/9K+eyjXtUhTaCxoQ7oYKW2J2hxdgEDXFK4=; b=K
	wq900+FKA9/VVVrbuct+Bh1NOdVHEVq/7wXKH3CgvmlB6WxfJ8JDzDRAbZFnS/Yx
	PUYxa2RkBWb4Qn09xhJ+Csm/m9GoIkcGgrW9QR3DguouTS49DyFgZINYvKUgcjg1
	/c/e2M6yT8Lr8wsyMQE6LvSvh1d08efyJTZJ8o1AN/VPebdjQx/rpiCeDBv+HvRy
	to+FsR4YXedj2AavdOF5F6Mc8Su20bTX0CKMzGcbXxErhGD0uKeTyrKr2agJCxQ2
	P0dyJbay9BUt/J7VcLdXzm/v9U0rfNte2SeTYc5HqrzsjS0Nks8xJcS3fORwKtQm
	GSlBTyUvh1gsTY6vu9paQ==
X-ME-Sender: <xms:kaAqZ6kjNuGqnUz48pmVC2v9eEbfGGBU1hKpNnGebTEnu6zeJZ7t9w>
    <xme:kaAqZx0h2T1ZgqeUG1PdxdL2fatLvJB-32L9XUZOoC2cAT1q-UWpz1iywzYsghONq
    6x4p4GPqg74kJ3hSbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnoh
    hvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfeuvdehteeghedthedt
    veehuddvjeejgffgieejvdegkefhfeelheekhedvffehnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohes
    shhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehshhihrghmqdhsuhhnuggrrhdrshdqkhesrghmugdrtghomhdprhgt
    phhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpth
    htohepihhkvgdrphgrnhestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopegrlhgv
    gigsvghlmhegkeesghhmrghilhdrtghomhdprhgtphhtthhopegtohhrvghnthhinhdrtg
    hhrghrhiesghhmrghilhdrtghomhdprhgtphhtthhopehluhiimhgrgihimhhilhhirghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhmhheshhhmhhdrvghnghdrsghrpdhrtg
    hpthhtohepshhohigvrhesihhrlhdrhhhupdhrtghpthhtoheplhgvnhgssehkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:kaAqZ4p_Tw3SaEL7xphiSA9NcGmZcLWYNpGC8ofhustJRdTqPelyiw>
    <xmx:kaAqZ-m1iptkUeZYGfTiGrM4h0yxd0dFLocJNJPyA3yG6h4-H5M3zA>
    <xmx:kaAqZ42OjtYTrNwkm4faA5c-QhvBhcevMYSGMo9UCnPePs7wzR4vTA>
    <xmx:kaAqZ1v8p59t_dqKwcqkxNYxp_KT0490wOUY1NLwPrqpqQ6LnD6WXA>
    <xmx:k6AqZyWu_6f-4XtOV_I5AVJz_tUh556HPG7itv28mOH8XGD1tqhEsE88>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B81163C0068; Tue,  5 Nov 2024 17:47:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 05 Nov 2024 17:47:25 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Maximilian Luz" <luzmaximilian@gmail.com>, "Lee Chun-Yi" <jlee@suse.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Corentin Chary" <corentin.chary@gmail.com>,
 "Luke D . Jones" <luke@ljones.dev>, "Ike Panhc" <ike.pan@canonical.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Alexis Belmonte" <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Ai Chao" <aichao@kylinos.cn>, "Gergo Koteles" <soyer@irl.hu>,
 "open list" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>,
 "Matthew Schwartz" <matthew.schwartz@linux.dev>
Message-Id: <26a494ee-d929-4aee-9c2e-d184e0efb842@app.fastmail.com>
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
Subject: Re: [PATCH v4 00/20] Add support for binding ACPI platform profile to multiple
 drivers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Mario,

On Tue, Nov 5, 2024, at 10:32 AM, Mario Limonciello wrote:
> Currently there are a number of ASUS products on the market that happen to
> have ACPI objects for amd-pmf to bind to as well as an ACPI platform
> profile provided by asus-wmi.
>
> The ACPI platform profile support created by amd-pmf on these ASUS
> products is "Function 9" which is specifically for "BIOS or EC
> notification" of power slider position. This feature is actively used
> by some designs such as Framework 13 and Framework 16.
>
> On these ASUS designs we keep on quirking more and more of them to turn
> off this notification so that asus-wmi can bind.
>
> This however isn't how Windows works.  "Multiple" things are notified for
> the power slider position. This series adjusts Linux to behave similarly.
>
> Multiple drivers can now register an ACPI platform profile and will react
> to set requests.
>
> To avoid chaos, only positions that are common to both drivers are
> accepted when the legacy /sys/firmware/acpi/platform_profile interface
> is used.
>
> This series also adds a new concept of a "custom" profile.  This allows
> userspace to discover that there are multiple driver handlers that are
> configured differently.
>
> This series also allows dropping all of the PMF quirks from amd-pmf.
>
> v4:
>  * Drop the list; iterate classes
>  * Drop patches that didn't make sense without list
>  * Cover alienware-wmi as well (recently merged to platform-x86/for-next)
>  * Drop requirement for balanced
>  * Rename platform-profile class members to 'profile', 'options', 'name'
>  * Drop the name in /sys/class/platform-profile and just use ida value.
>    IE platform-profile-0
>
> Mario Limonciello (20):
>   ACPI: platform-profile: Add a name member to handlers
>   platform/x86/dell: dell-pc: Create platform device
>   ACPI: platform_profile: Add device pointer into platform profile
>     handler
>   ACPI: platform_profile: Add platform handler argument to
>     platform_profile_remove()
>   ACPI: platform_profile: Move sanity check out of the mutex
>   ACPI: platform_profile: Move matching string for new profile out of
>     mutex
>   ACPI: platform_profile: Use guard(mutex) for register/unregister
>   ACPI: platform_profile: Use `scoped_cond_guard`
>   ACPI: platform_profile: Create class for ACPI platform profile
>   ACPI: platform_profile: Add name attribute to class interface
>   ACPI: platform_profile: Add choices attribute for class interface
>   ACPI: platform_profile: Add profile attribute for class interface
>   ACPI: platform_profile: Notify change events on register and
>     unregister
>   ACPI: platform_profile: Only show profiles common for all handlers
>   ACPI: platform_profile: Add concept of a "custom" profile
>   ACPI: platform_profile: Make sure all profile handlers agree on
>     profile
>   ACPI: platform_profile: Check all profile handler to calculate next
>   ACPI: platform_profile: Allow multiple handlers
>   platform/x86/amd: pmf: Drop all quirks
>   Documentation: Add documentation about class interface for platform
>     profiles
>
>  .../userspace-api/sysfs-platform_profile.rst  |  28 ++
>  drivers/acpi/platform_profile.c               | 446 ++++++++++++++----
>  .../surface/surface_platform_profile.c        |   8 +-
>  drivers/platform/x86/acer-wmi.c               |  10 +-
>  drivers/platform/x86/amd/pmf/Makefile         |   2 +-
>  drivers/platform/x86/amd/pmf/core.c           |   1 -
>  drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
>  drivers/platform/x86/amd/pmf/pmf.h            |   3 -
>  drivers/platform/x86/amd/pmf/sps.c            |   4 +-
>  drivers/platform/x86/asus-wmi.c               |   6 +-
>  drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
>  drivers/platform/x86/dell/dell-pc.c           |  39 +-
>  drivers/platform/x86/hp/hp-wmi.c              |   8 +-
>  drivers/platform/x86/ideapad-laptop.c         |   4 +-
>  .../platform/x86/inspur_platform_profile.c    |   7 +-
>  drivers/platform/x86/thinkpad_acpi.c          |   4 +-
>  include/linux/platform_profile.h              |   7 +-
>  17 files changed, 456 insertions(+), 195 deletions(-)
>  delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>
>
> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
> -- 
> 2.43.0

For the series - I tried it out on my T14s G6 AMD, and it all looks to be working nicely and as expected.
The thinkpad-acpi and amd-pmf classes show up. I can tweak them individually and 'custom' shows up under firmware/acpi/platform_profile.
I tried various combo's and didn't see any issues.
If you have any recommendations of things to try let me know.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

