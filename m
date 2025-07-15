Return-Path: <linux-acpi+bounces-15165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9101B05AA9
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 14:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD9E16DE07
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8992D8790;
	Tue, 15 Jul 2025 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JwdFa28O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B305E274FDB;
	Tue, 15 Jul 2025 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584033; cv=none; b=D5vAHSGjVH4j0QVWOVj2jGAu6bb4W8ples1T1QpmsYCP20b/STJ9D0coLSq2MgZkgsoKiWpZ5b7wjb5VPkPiFqnzUTnuaYVzFLr/FSJ7fv1T2ZiHREby2KPeiDSX1W8w8S2UdcRw9ueAJ9QiE0aJfsS1MUxtyqT4ls4QPCyq1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584033; c=relaxed/simple;
	bh=VaardJX2iRea1C+C6uoZRox1q6VzhIfK0Xgf+GMvnwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0OOcYO+31Oysx0KyIHtRPgpfzJdQCVzIgWg6v6daQXo1OWCSO26NtXST6a7hiUNsYHY+IhJM386uPT/ffTpYbrMAOhQ/SwOqOn/jgK9mBF4fUhkB22YuPtQZ1aJBrr1S6k/cHsn8w7KkFjDz3d8kFD+gGnx7qqzrAfO4MNNfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JwdFa28O reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C5A140E00DE;
	Tue, 15 Jul 2025 12:53:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AX8hCwGg8sVx; Tue, 15 Jul 2025 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752584025; bh=qRq/rWrw1WYtVn6UsmTaFfjIP6wqH9ETQ4UF4JDPXFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JwdFa28OHtMTLkVIDW9inpXxxF9Io5b4ZzlEM1y96/+bemxZmQFtRBNSm73xqY2qH
	 O4a4maWyMsbcYB+jtUPex3xRtNWMMFShL16RvWKWTs/EG2WWlKRzlDPr9bhUFs5GtJ
	 cTn5QJl4jNoO9s5h/56+KtmoKWxDIF1fcIGrmTCCc5JusIYrdUfZmOMsV2tg3cWnQT
	 DTybTRSpT4f7rruqYfQMbEYwPd59rFKiQ32Y0d29NyStDayNX5gSMsqD1VjhqDzhN1
	 wvwEf3vtDiRAvzqnxi3+yzs/OrKcJrftG4JQgCh10bdTWuGCFIHBDJA7BL0v3YS93U
	 /AALXxVm4sPMSD4F+t3mlZ2eITP30YWZteynPse2LTz1TqTl+cdvfZc6kuXC9sjuws
	 4RTeoz8KnJsDgNDQxZdYHeWhZkO5pcy+Ct1VUH1kj4+kv/qMuudmfiMgQsHurYMmh2
	 HDCZHltnpxw9557RxmMbub16VUOJcLjFexCniVZO3X34MdmnTAaeTGU4/Ltq7LqJNb
	 J9r16tWLM7H7na30o3EreeiEBjLvIWJJLIQXsWp32GFk5lUN/MpK5U7hcxknDA/Jj6
	 qGF3pQEQ4HSnMGwBPa310AVOqjQGtgXTVErfcKBdws1orhXRYmsfc3IAgjiw+kN4OT
	 L0wMY3hGyRXkrYfcULztYub4=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F8B040E0216;
	Tue, 15 Jul 2025 12:53:32 +0000 (UTC)
Date: Tue, 15 Jul 2025 14:53:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>, Alexander Graf <graf@amazon.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Gonda <pgonda@google.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	"Moore, Robert" <robert.moore@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 05:02:39AM -0700, Breno Leitao wrote:
> Hello Borislav,
>=20
> On Tue, Jul 15, 2025 at 12:31:25PM +0200, Borislav Petkov wrote:
> > On Tue, Jul 15, 2025 at 03:20:35AM -0700, Breno Leitao wrote:
> > > For instance, If every investigation (as you suggested above) take =
just
> > > a couple of minutes, there simply wouldn=E2=80=99t be enough hours =
in the day,
> > > even working 24x7, to keep up with the volume.
> >=20
> > Well, first of all, it would help considerably if you put the use cas=
e in the
> > commit message.
>=20
> Sorry, my bad. I can do better if we decide that this is worth pursuing=
.
>=20
> > Then, are you saying that when examining kernel crashes, you don't lo=
ok at
> > I find that hard to believe.
>=20
> We absolutely do examine kernel messages when investigating crashes, an=
d
> over time we've developed an extensive set of regular expressions to
> identify relevant errors.
>=20
> In practice, what you're describing is very similar to the workflow we
> already use. For example, here are just a few of the regex patterns we
> match in dmesg, grouped by category:
>=20
>     (r"Machine check: Processor context corrupt", "cpu"),
>     (r"Kernel panic - not syncing: Panicing machine check CPU died", "c=
pu"),
>     (r"Machine check: Data load in unrecoverable area of kernel", "memo=
ry"),
>     (r"Instruction fetch error in kernel", "memory"),
>     (r"\[Hardware Error\]: +section_type: memory error", "memory"),
>     (r"EDAC skx MC\d: HANDLING MCE MEMORY ERROR", "memory"),
>     (r"\[Hardware Error\]:   section_type: general processor error", "c=
pu"),
>     (r"UE memory read error on", "memory"),
>=20
> And that=E2=80=99s just a partial list. We have 26 regexps for various =
issues,
> and I wouldn=E2=80=99t be surprised if other large operators use a simi=
lar
> approach.
>=20
> While this system mostly works, there are real advantages to
> consolidating this logic in the kernel itself, as I=E2=80=99m proposing=
:
>=20
>     * Reduces the risk of mistakes
>     	- Less chance of missing changes or edge cases.
>=20
>     * Centralizes effort
> 	- Users don=E2=80=99t have to maintain their own lists; the logic live=
s
> 	  closer to the source of truth.
>=20
>     * Simplifies maintenance
> 	- Avoids the constant need to update regexps if message strings
> 	  change.
>=20
>     * Easier validation
> 	- It becomes straightforward to cross-check that all relevant
> 	  messages are being captured.
>=20
>     * Automatic accounting
> 	- Any new or updated messages are immediately reflected.
>=20
>     * Lower postmortem overhead
> 	- Requires less supporting infrastructure for crash analysis.
>=20
>     * Netconsole support
> 	- Makes this status data available via netconsole, which is
> 	  helpful for those users.

Yap, this is more like it. Those sound to me like good reasons to have th=
is
additional logging.

It would be really good to sync with other cloud providers here so that w=
e can
do this one solution which fits all. Lemme CC some other folks I know who=
 do
cloud gunk and leave the whole mail for their pleasure.

Newly CCed folks, you know how to find the whole discussion. :-)

Thx.

> > Because if you do look at dmesg and if you would grep it for hw error=
s - we do
> > log those if desired, AFAIR - you don't need anything new.
>=20
> Understood. If you don=E2=80=99t see additional value in kernel-side
> counting, I can certainly keep relying on our current method. For
> us, though, having this functionality built in feels more robust and
> sustainable.
>=20
> Thanks for the discussion,
> --breno

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

