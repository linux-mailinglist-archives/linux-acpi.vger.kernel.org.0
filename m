Return-Path: <linux-acpi+bounces-929-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F0C7D58F6
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A904C1C2032A
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DCF3B29B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kxVNKjaE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B987836B16;
	Tue, 24 Oct 2023 15:27:38 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C901BFD;
	Tue, 24 Oct 2023 08:27:35 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BDA5E40E0177;
	Tue, 24 Oct 2023 15:27:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id O_JSFRhFDTp4; Tue, 24 Oct 2023 15:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1698161247; bh=/VWdzD9YqeMFT65D6FtCfwIaXeG447+7p1CdxoXwJIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxVNKjaESkPKWatKh8WeOOZKJ1ZfuaVgDgM5/UvVCoZlAhb/b4CbP8xsjt1HY2cc6
	 cPkTwoQYuFxjl+AdYlPC7hESHx+YK3oFQSBcgS+YlbDEQa+h4+0dCMg41ECN13GMYI
	 nH1Iz6JUmr85Y5GCdr/yhS8It5WFj+yININjan7rHmAbqjNzsbBYpms2MHGTnCcoAQ
	 BPbLKYuIhv/q0U/L1STtsox8pBhcEdGb8G7QGWTS5j5QUGDYC5I6dUE7AbDp70tAAB
	 36L1gEGMBqJJyOcSJ0ydPSRMUmH/giseiKlmic3b3803vyKw4XSvlYS8Scj9+kAe6N
	 7TlyQiZ8oBWEwlbxb67JD/OVMdj1IuaGZhZV+cqNOQjjLpAT1AAmHqo47HgyFL7QwJ
	 GijTGKb6VRCn1iu769UdbfYFnNL0eLTd1qGzH+Ovz3gYuJrYn71DRCCRkP+lsKUUax
	 DJ8TYDNQ8gXyo48Yo3pxa1VdknGw7lEcgJp9RdG9K+lvbYmQGs2Gf1RDqiWiLXBJAq
	 Md5zXKTrrrrqbJAPuGAhHAXm8E+aiv6h+R56fNBVnzLbl0/Lp6MW3skoeQ/lBx7kLE
	 wdW6TaKOdvztuK78ATMHsCHvQFylhc/OqHpKlMboJlm1GbEixaCMrgnuDCGz1Mp2yd
	 EjxWAJVMZVEuqWIKanOOmBEs=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55E4240E014B;
	Tue, 24 Oct 2023 15:27:14 +0000 (UTC)
Date: Tue, 24 Oct 2023 17:27:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jeshua Smith <jeshuas@nvidia.com>, "Luck, Tony" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"gpiccoli@igalia.com" <gpiccoli@igalia.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Message-ID: <20231024152708.GFZTfiTL9C6onZKn99@fat_crate.local>
References: <20230712223448.145079-1-jeshuas@nvidia.com>
 <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <DM6PR12MB3371D86F80417641B8479B28DB0EA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371FA3AEEA4D17D94C889D5DB1BA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB337153EE2DDDB427096446F0DBF2A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371083F4E6BCE4A8D2389E7DBC5A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB33710C8FE59EB3CB1404ABC0DBD8A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <CAJZ5v0g2TsBo4hxsJBo5a-ggD2Cj65VS=tokpoRaNwzWbPoeNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g2TsBo4hxsJBo5a-ggD2Cj65VS=tokpoRaNwzWbPoeNw@mail.gmail.com>

On Tue, Oct 24, 2023 at 04:32:48PM +0200, Rafael J. Wysocki wrote:
> So there are 3 designated reviewers for APEI: Tony Luck, Borislav
> Petkov and James Morse.  I need an ACK or Reviewed-by from one of
> them, so I can proceed with an APEI patch.

Here's what I see:

cat /tmp/patch | ./scripts/get_maintainer.pl
Kees Cook <keescook@chromium.org> (supporter:PSTORE FILESYSTEM)
Tony Luck <tony.luck@intel.com> (reviewer:PSTORE FILESYSTEM)
"Guilherme G. Piccoli" <gpiccoli@igalia.com> (reviewer:PSTORE FILESYSTEM)
"Rafael J. Wysocki" <rafael@kernel.org> (unknown:ACPI APEI)
Len Brown <lenb@kernel.org> (reviewer:ACPI APEI)
James Morse <james.morse@arm.com> (reviewer:ACPI APEI)
Borislav Petkov <bp@alien8.de> (reviewer:ACPI APEI)

so I'm guessing Kees, Tony, Guilherme ...

From what I can see, the change itself is making me ask more questions:

When I see "may" in commit messages "Slow devices such as flash may not
meet the default 1ms timeout value" then I wanna know what devices are
those?

What is the actual use case here?

Upthread there's a question about the ACPI spec. That should be
explained too. Because I have no clue what "the ERST max execution time
value" is.

And so on.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

