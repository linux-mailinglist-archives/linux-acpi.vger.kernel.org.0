Return-Path: <linux-acpi+bounces-10747-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D55A158B9
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 21:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0677A05CA
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 20:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60541A9B52;
	Fri, 17 Jan 2025 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="FaQ1C/na";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lra2iHOm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F11A2391;
	Fri, 17 Jan 2025 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737146759; cv=none; b=jAoaSBdx7e9qcvP43+r3LXHK+22JYzFukoZSI62jUMgDbBHiZt1GnZb8xOCBg0WhgUjhUGHv/lkWp9wE5xFQUkEKgQJ9juvz1OqSRTycwjm5/bo3cBIk7mKMWJDkvUZDrx7DbG4bfVn/R3rXvDVAlLMUkEo+aSR3jimLc+5xFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737146759; c=relaxed/simple;
	bh=R3bxWaNPovaejlYe9BjfKkvP92mDWlZrDXDzSjZA3Aw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dWtqL0CJCJLQugAzhe3S/PNCmskLFeKCyYOWYACw5//tab7Lou1aD19MRSwPKspW0RpVm8lbiHDbcC42lggBEnOSB1Ec6nXQDmeGaHQP8HcabDIXktPnSQow4C2rP6zQFhcOq+QQcXr+N22UNoIESQ811l7HA+xmtsolDdwrItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=FaQ1C/na; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lra2iHOm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B2E1613801F7;
	Fri, 17 Jan 2025 15:45:56 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jan 2025 15:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737146756;
	 x=1737233156; bh=bm5w52HLJMVDLIxXBhpPYfOqcVvLk7HCvS+VcMPBAgM=; b=
	FaQ1C/naLXYi4hXLVWijAXyxD0zTMStzPCcfZ0zxiSLpI6V96/+fzwcU8RtM1ROK
	dsdnys2Yq34SABpYip/b0JWv77hjQIcB3bsrGxYBy2/UMSaDmoaB1pqxJATYCQOR
	abliUK3nuPW7FShSzERnTjuSA8Qzg3dYiXfE+wS++lgnGLxKtdRWbqA82Bv1o6g3
	40d6LbMcDBTcqjX8jff0uLjXqt1H0TEmvqIWZiqWb6PjVI75AVZhu6oflKSV9aDv
	147srD2S/WsD6VtvpTxUg7pIV/ZEKhr3d2D0guJNXmH7r7LvIb2NN7rilsD0/S+w
	pBb5i++cezCAGknGaFKIug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737146756; x=
	1737233156; bh=bm5w52HLJMVDLIxXBhpPYfOqcVvLk7HCvS+VcMPBAgM=; b=L
	ra2iHOmzAfTcPD/XytYS3xsfai31edigy+315J/RPfIHU/5JA4cSxqmH6mH80wjF
	lptNspmQcEJEYXYQ/g+4FWr3iZK4igTL5vJPQD8Fe5k+r1LuMqZJkKtCrYdHi7Dr
	S3z+svXLEWHSNIVQmiJrEGHmjoC9uL/LNKNCNb78y1hMyRGTZwFkqiTb5LM7Uz72
	icl8iE3CIAbcqMqeDY0e5t1dOfFi6mBCvn2fqa+Kzp9LzVmn8/54EQ2oXf4qy7s6
	bLeU204+6/XC3KBuZX1LjiWokyWQLuNKTwOLpojU7+j1hFtPip0O+2/NauBMKeAo
	+/a5bkm0qNqrw618nxMsw==
X-ME-Sender: <xms:g8GKZ3KI0M55Hnofk89kyCPMJXjadTi95CvCSV0UKXOcpfwZyvdlwQ>
    <xme:g8GKZ7KgblbKK5DSe9AlER0pBBi-pbPTbaLu6tdQbs9M4PCZb02cVooiHrW-SguKX
    HZd0wOwQtMkBAGjrXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhepgedvgeeufffhtdel
    iefgjefhgffgiedvjeegleeujeeutdduteehjeduhedtiedtnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprh
    gtphhtthhopedvhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhhigrmhdq
    shhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimh
    honhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehikhgvrdhprghnsegtrghn
    ohhnihgtrghlrdgtohhmpdhrtghpthhtohepuggvlhhlrdgtlhhivghnthdrkhgvrhhnvg
    hlseguvghllhdrtghomhdprhgtphhtthhopegrlhgvgigsvghlmhegkeesghhmrghilhdr
    tghomhdprhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomh
    dprhgtphhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhhuuhhrthgssehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrg
    igihhmihhlihgrnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:g8GKZ_uv8qiN7wIPMqJFhMa3vk6pU0-UPRcMz2swN3lMmqtedTbnAQ>
    <xmx:g8GKZwbctyOfsLQMHO11ukM3DxUWzQqvUsiv5RmQUH7tTbgzeEdRGg>
    <xmx:g8GKZ-bWwarsM7rnNKK3GMDRXnn1JBOOa6RUyKmkgFIWwpqLo0eB6w>
    <xmx:g8GKZ0DAieznYcPIIDvWM84Igxl1_tDRVbTOjKkDmURPCBgZn1AAJA>
    <xmx:hMGKZ6IrUFnuabx6ZZ0II-b2HqvGb76HcyCH9-3uzDRu_LrYXJ3ilhaN>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 274CD3C0066; Fri, 17 Jan 2025 15:45:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 Jan 2025 15:45:34 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Kurt Borja" <kuurtb@gmail.com>
Cc: 
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Armin Wolf" <W_Armin@gmx.de>, "Joshua Grisham" <josh@joshuagrisham.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 "Maximilian Luz" <luzmaximilian@gmail.com>, "Lee Chun-Yi" <jlee@suse.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Corentin Chary" <corentin.chary@gmail.com>,
 "Luke D . Jones" <luke@ljones.dev>, "Lyndon Sanche" <lsanche@lyndeno.ca>,
 "Ike Panhc" <ike.pan@canonical.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Alexis Belmonte" <alexbelm48@gmail.com>, "Ai Chao" <aichao@kylinos.cn>,
 "Gergo Koteles" <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
Message-Id: <f4e08213-0f42-4f35-a150-a75bf91537bf@app.fastmail.com>
In-Reply-To: <f8678f9c-56c2-b3a9-f24d-04c9433dba9f@linux.intel.com>
References: <20250116002721.75592-1-kuurtb@gmail.com>
 <1eb2720a-c9af-4e5c-8df2-c4ce3c017d5c@app.fastmail.com>
 <3aab5072-f032-7458-56af-1d45e89a5d44@linux.intel.com>
 <D74IM4AZ87C9.1R1S1KOA89PX7@gmail.com>
 <f8678f9c-56c2-b3a9-f24d-04c9433dba9f@linux.intel.com>
Subject: Re: [PATCH v4 00/19] Hide platform_profile_handler from consumers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 17, 2025, at 12:19 PM, Ilpo J=C3=A4rvinen wrote:
> On Fri, 17 Jan 2025, Kurt Borja wrote:
>
>> On Fri Jan 17, 2025 at 11:42 AM -05, Ilpo J=C3=A4rvinen wrote:
>> > On Thu, 16 Jan 2025, Mark Pearson wrote:
>> >
>> > > Hi
>> > >=20
>> > > On Wed, Jan 15, 2025, at 7:27 PM, Kurt Borja wrote:
>> > > > Hi :)
>> > > >
>> > > > The merge window is about to open, so I rebased this patchset o=
n top of
>> > > > pdx86/review-ilpo-next to pick up acer-wmi latest commits, in c=
ase we
>> > > > manage to squeeze this into v6.14.
>> > > >
>> > > > ~ Kurt
>> > > > ---
>> > > > v3 -> v4:
>> > > >
>> > > > [09/19]
>> > > >   - Replace error message with a user-friendly one
>> > > >
>> > > > v3:=20
>> > > > https://lore.kernel.org/platform-driver-x86/20250115071022.4815=
-1-kuurtb@gmail.com/
>> > > >
>> > > > Kurt Borja (19):
>> > > >   ACPI: platform_profile: Replace *class_dev member with class_=
dev
>> > > >   ACPI: platform_profile: Let drivers set drvdata to the class =
device
>> > > >   ACPI: platform_profile: Remove platform_profile_handler from =
callbacks
>> > > >   ACPI: platform_profile: Add `ops` member to handlers
>> > > >   ACPI: platform_profile: Add `probe` to platform_profile_ops
>> > > >   platform/surface: surface_platform_profile: Use
>> > > >     devm_platform_profile_register()
>> > > >   platform/x86: acer-wmi: Use devm_platform_profile_register()
>> > > >   platform/x86: amd: pmf: sps: Use devm_platform_profile_regist=
er()
>> > > >   platform/x86: asus-wmi: Use devm_platform_profile_register()
>> > > >   platform/x86: dell-pc: Use devm_platform_profile_register()
>> > > >   platform/x86: ideapad-laptop: Use devm_platform_profile_regis=
ter()
>> > > >   platform/x86: hp-wmi: Use devm_platform_profile_register()
>> > > >   platform/x86: inspur_platform_profile: Use
>> > > >     devm_platform_profile_register()
>> > > >   platform/x86: thinkpad_acpi: Use devm_platform_profile_regist=
er()
>> > > >   ACPI: platform_profile: Remove platform_profile_handler from =
exported
>> > > >     symbols
>> > > >   ACPI: platform_profile: Move platform_profile_handler
>> > > >   ACPI: platform_profile: Clean platform_profile_handler
>> > > >   ACPI: platform_profile: Add documentation
>> > > >   ACPI: platform_profile: Add a prefix to log messages
>> > > >
>> > > >  .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
>> > > >  drivers/acpi/platform_profile.c               | 172 ++++++++++=
+++-----
>> > > >  .../surface/surface_platform_profile.c        |  48 ++---
>> > > >  drivers/platform/x86/acer-wmi.c               | 114 ++++++----=
--
>> > > >  drivers/platform/x86/amd/pmf/core.c           |   1 -
>> > > >  drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
>> > > >  drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
>> > > >  drivers/platform/x86/asus-wmi.c               |  55 +++---
>> > > >  drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
>> > > >  drivers/platform/x86/dell/dell-pc.c           |  60 +++---
>> > > >  drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
>> > > >  drivers/platform/x86/ideapad-laptop.c         |  45 +++--
>> > > >  .../platform/x86/inspur_platform_profile.c    |  48 +++--
>> > > >  drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
>> > > >  include/linux/platform_profile.h              |  37 ++--
>> > > >  15 files changed, 495 insertions(+), 337 deletions(-)
>> > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-platf=
orm-profile
>> > > >
>> > > >
>> > > > base-commit: d98bf6a6ed61a8047e199495b0887cce392f8e5b
>> > > > --=20
>> > > > 2.48.1
>> > >=20
>> > > For the series up to v4 commit 15/19:
>> > > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> > >=20
>> > > I need to go over the last few commits just once more, as there a=
 few=20
>> > > pieces I need to get my head around - and I'm not going to get it=
 done=20
>> > > this evening. Hope it's OK to add review for the bits that I have=
 done.
>> >
>> > I, for the first time ever, tested filter-branch and after some ini=
tial=20
>> > hickups on how to specify the commit range, got your Reviewed-bys a=
dded
>> > with single command :-).
>>=20
>> Awesome! I believe commit 15/19
>>=20
>> a213108c01e0 ("ACPI: platform_profile: Remove platform_profile_handle=
r from exported symbols")
>>=20
>> is still missing a rev-by by Mark, if there is still time.
>
> Thanks for noticing this. I just recalled the patch numbering wrong.
>
> It should be fixed now.
>
> --=20
>  i.

I finished my review, and no concerns. For the series:
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Note - I'm building and will give it a sniff test too, but that will tak=
e a bit longer.

Thanks for your work on this Kurt

Mark

