Return-Path: <linux-acpi+bounces-12777-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996FBA7DF14
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 15:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73FB7A3038
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 13:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4E0253B76;
	Mon,  7 Apr 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="kxxOzJQ0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from gmmr-3.centrum.cz (gmmr-3.centrum.cz [46.255.225.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8B023C8A7;
	Mon,  7 Apr 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.225.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032393; cv=none; b=RBm/2YXF5/CgXWgeD94cGatTRwux6mHDVffVbhud59iid92f+jstv4rqpJ4APxEIzarRPk941p/VarPEOUh7jLYWw2FONomkU8GR3ZvvVTfY0W6ra9qpoffXwkGVVl9gVB89PneQeJK0WGvsS68ApZRxD8hnIygqIUMLnSES6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032393; c=relaxed/simple;
	bh=oVcbyNbVpWntVn2cBpxzRPa8JBTsDG5aDFBPFGq4DIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ae9aj7y5dH/FbaOaKp1dXH6jYyvT3AAUFwY1MYFseedfcprQNMYzrsQx9/MwUO46R3HMCXPpFbUiKrGwe4q4NS3/A6elc7WxQ43LsAN86VLOoTKdDTRkzPpwuPc4LBp+lCyv/vKpFKKu3OBgWylqzIWRQiKvlifm88KMr/KKIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=kxxOzJQ0; arc=none smtp.client-ip=46.255.225.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-3.centrum.cz (localhost [127.0.0.1])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 8BD86205DA3A;
	Mon,  7 Apr 2025 15:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1744032303; bh=kiYJQhPO9bK188tvzcgK+tflLcoJpt76+LU/uqMEgG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxxOzJQ0P6GLAuQTlOjnqZNKg/UGOpr+RUEKzDYxwBBcPfASASQ0pfF1lriUHs51g
	 gXZuldOPgZmnoDXdyZs0JQWUWQkbvnVN6cQpwlmG7LcmQPcmbqnzHZmnkNF/uiQ5Bt
	 FXyFjFa/8ScmHKobTu//880y/QwKnJgALZDVo88A=
Received: from antispam31.centrum.cz (antispam31.cent [10.30.208.31])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 44D60205DA48;
	Mon,  7 Apr 2025 15:25:03 +0200 (CEST)
X-CSE-ConnectionGUID: JISPTSTgQ0+NWz5v7Bd6/g==
X-CSE-MsgGUID: WG/Zq+uhSNeWMb8Z2bJYQQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EHAADz0PNn/0vj/y5aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQAmBOAMBAQEBCwGDM4ZGkXIDi3aGM4tqgX4PAQEBAQEBAQEBC?=
 =?us-ascii?q?UQEAQGEfQoCiyonNgcOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQYBAQEBAQEGB?=
 =?us-ascii?q?gECgR2FNVOCYgGDfwEBAQECASMPAUYFCwsNAQoCAiYCAlYGgxWCMAERI6wwe?=
 =?us-ascii?q?oEyGgJl3HACgSNkgSmBGi4BiE8BhHxwG4RcQoINgRWCeTE+hBuEA4JpBIItR?=
 =?us-ascii?q?VWUEoxjSAp7HANZLAFVEw0KCwcFgSlDAzUMCy4VIw9EBTMdgXyDcoU4ghGBX?=
 =?us-ascii?q?AMDIgGDFXUchG6EWi1PgzM8HUADCxgNSBEsNxQbBj0BbgeadFmBWwo+AsdOh?=
 =?us-ascii?q?CWETZx7GjOXUh4DkmSYfqRLhGiBbguCBDMiMIMjURmOaMwBgTICBwEKAQEDC?=
 =?us-ascii?q?YI7jS4zgUsBAQ?=
IronPort-PHdr: A9a23:/eJw7xHX04iMZwfbeyb7tJ1Gf35KhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k21hmRBc6Bs6oe26L/iOPJZy8p2d65qncMcZhBBVcuqP49uEgNJvDAImDAaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 RuooQnLqsUanYRuJrgtxhfVvHdFePldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U
 7NVCSktPn426sP2qxTNVBOD6HQEXGoZixZFHQfL4gziUpj+riX1uOx92DKHPcLtVrA7RS6i7
 6ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWWROQNpeVy1ZAoO9c
 YQPCfYBPf1FpIX5vlcCsAeyCRWpCO7p1zRGhGL53bci3uohDw/LwhEuEdwNvnrTrtr1OqgdX
 vy6wqTT0TXObOlb1Svn5YTUcB0sp+yHU7JqccrWzEkiDxnLgUuMqYz/Ijia2f4Cs26F6upjS
 OmijHQoqxtyoje1w8cjkJPJi5kPxVDY8SV22p01KcekR096eNOpFoZbuC6GOYVsWMwiX31ot
 zggyr0AoZO3YTQGxZsnyRLCb/GJc5WF7w7jWuieLjp1h3Nodb2wihiy8kWt1OLyW8q23VtEr
 ydIktbBum0O2hHR68WLV/hw80G80jiMzwDe8u5JLEEumabFK5MswqQ8moQNvUnBBCP7mkX7g
 LeIekk59OWk8frrbqv6qpOGKYN5hR3yPr4ql8G+B+kzLxIAUHKB+eum0b3u5Uj5QLJXgfIoi
 qTZq5XaJdgDpq6+Hg9Vzp4v6xahADei19QVhXYHLFdcdBKciojpJ0nOLO3lAfuln1ujjjFrx
 +zcPr38B5XBNGTMkbb5cbZ87U5T1hYzwMhQ6p9VEL0NPvL+V0/ruNDGEBM0MRa4zuTnBdll0
 4MRQ2OPAquXMKPItl+I4/oiLPOWZI8Wojn9LuIq5+T1gHAjhV8debOm3YANZH+kH/VqO1+Zb
 mb0gtcdDWcKuRIzQ/bwiF2BSzFTYmy9X7gn6z4hFIKmCZ3MRpu3jLOd3Sa3BodWaXxeClCQD
 XfocJ2JVO0KaC2POM9ujDIFWaK9RI8m0hGurBH1y6BpI+fP5iIYtI7j1MJ05+zcjx096Tt0D
 8GF32GXU250hn8IRyMx3K1nrk1wyVaO3LN7g/NGD9xT4e1GUgMgOZ7b1ex6BMj+WhjdcdeRV
 FamXtKmDCktTtI+x98PbF1wG9GjjhDFwiqqH6UVl7uNBJw1/aPQxWX+KNhlx3bcyKYhl0UmQ
 tdINWC+ia9w6Q7TC5fUnEqHiaala6Ac0TXJ9GeC1mqOoFpYXBR/UKrbW3AfflHWrdP75kzcU
 7CuFa4rMgxbyc6NMqdKcMHmjU1aRPf/P9TTe2Cxm2iqBRaP3bOMd5Hne34A3CXGFkcIiRwc/
 XGDNQQmHCeuv3reDCByFVLoe07s9eh+qHWmTk471g2FdVFu16K0+hMOm/ycRO0c3qgetCcit
 Tp0BlC90MzSC9aaoAphZqpcbcsn4FhbzWLZqxB9Ppu4IqBmh14edRl3vkz32xV0FIpAi84qo
 20uzAdpN6KY301OdymC0ZDzJLLXMG/y8w6ra6LM3VHeytmWqe8z76EEq1LmtRrhOU4v8mVh3
 sMdh2eT4oXiCAsUTI7rVUA25152queJTDM64tbs2GF2eZe9tJzBk4YgHugszx+6V95DNKqfU
 gTgRZ5JT/OyIfAnzgD6JikPO/pfoettZ5vOSg==
IronPort-Data: A9a23:qYR9uqv9Qc3XtNVlAKtlOG8abefnVKtfMUV32f8akzHdYApBsoF/q
 tZmKWqAaPmCMGv2L913YdjioUIOvsPWytIyHlM/+3szQi8WgMeUXt7xwmUcns+xwm8vaGo9s
 q3yv/GZdJhcokf0/0rrb/646yEhiMlkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGZTdJ5xYuajhJs/7b90sz1BjPkGpwUmIWNK0jUGD2yCF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg7TrEFt0Yfec8Agqe0Iw/ylWZcWq8VJcSJS1mZT7I0buKxMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lTDG4v96N/L2CEqpKudZ+MpbBMN1YtSQ1pd3ZJa5OrZHrTKCP/tpExG5pwMtDG+rEe
 s9fYigHgBboP0MJYApKTshkw6H32xETcBUBwL6RjaMt4GHWxRZZ2aTpOcGTcc7iqcB9xx7F9
 jqWoz6kav0cHOOwjgicsW+svcnCogbxCLBIHp+Jz8c/1TV/wURWUnX6T2CTqOO6g0u3QfpWN
 0gd4Wwlv8Aa/UqnVNTiGRa/p2aJpEU0UNtMCewqrgqKz8L881bHLmsJVDhMbJohrsBebSAl0
 k+hm9LvGCB1t7uUWTSR+9+8vT60fCQYM2IGTSsFVhcepcnuppkpiRDCRcolF7S65vX3Fiv32
 CuitzUlivMYistj/6G6+03XxjunvpnhUAE4/EPUU3ij4wc/Y5SqD6Ss6F7G/bNDIZyfQ12po
 ncJgY6d4foIAJXLkzaCKM0WALij4/utLjLRmxhsEoMn+jDr/GSsFb28+xkiegEzb5tCI2W2J
 hCO0e9M2KJu0LKRRfcfS+qM5w4CkMAMyfyNuijoU+dz
IronPort-HdrOrdr: A9a23:7g/t9KFVCio9xU1RpLqE5ceALOsnbusQ8zAXPo5KJSC9Ffbo8P
 xG/c5rsSMc5wx+ZJhNo7q90ey7MBDhHP1OkOws1NWZPTUO0VHAROpfBMnZsl/d8kbFmdK1u5
 0MT0EHMr3NMWQ=
X-Talos-CUID: 9a23:SieH+GBevB5e4mn6EwtGz3YoIfwqSyWe6kjCflHnI2o3D7LAHA==
X-Talos-MUID: 9a23:y4XipQiW3w/A4lkwXJIGTsMpC+gv0b3tFUA2t5g5nsPUB3Z6GQaktWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,194,1739833200"; 
   d="scan'208";a="105808425"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam31.centrum.cz with ESMTP; 07 Apr 2025 15:25:02 +0200
Received: from localhost.localdomain (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id B408C100AE104;
	Mon,  7 Apr 2025 15:25:02 +0200 (CEST)
From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	arkamar@atlas.cz,
	Juergen Gross <jgross@suse.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/cpu/topology: Don't limit CPUs to 1 for Xen PV guests due to disabled APIC
Date: Mon,  7 Apr 2025 15:24:26 +0200
Message-ID: <20250407132445.6732-1-arkamar@atlas.cz>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <87ecy5wqjm.ffs@tglx>
References: <87ecy5wqjm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Apr 06, 2025 at 12:08:29PM +0200, Thomas Gleixner wrote:
> On Sat, Apr 05 2025 at 20:16, Petr Vaněk wrote:
> 
> > Xen PV guests in DomU have APIC disabled by design, which causes
> > topology_apply_cmdline_limits_early() to limit the number of possible
> > CPUs to 1, regardless of the configured number of vCPUs.
> 
> PV guests have a APIC emulation and there is no code which actually
> disables the APIC by design unconditionally. There is one way though,
> which disables the APIC indirectly.

It seems I have got a bit lost in APIC/ACPI abbreviations. Sorry.

> xen_arch_setup() disables ACPI, which in turn causes acpi_mps_check() to
> return 1, which disables the APIC. This only happens when the kernel
> configuration has:
> 
>      CONFIG_X86_MPPARSE=n
>      CONFIG_ACPI=y
> 
> If you enable MPPARSE the problem goes away, no?

Yes, it goes away.

> > +	/* 'maxcpus=0' 'nosmp' 'nolapic'
> > +	 *
> > +	 * The apic_is_disabled check is ignored for Xen PV domains because Xen
> > +	 * disables ACPI in unprivileged PV DomU guests, which would otherwise limit
> > +	 * CPUs to 1, even if multiple vCPUs were configured.
> 
> This is the wrong place as it invalidates the effect of 'nolapic' on the
> kernel command line for XEN PV.
> 
> You actually explain in the comment that XEN disables ACPI, so why are
> you slapping this xen check into this code instead of doing the obvious
> and prevent acpi_mps_check() to cause havoc?

Thank you for your explanation and suggestion. I will correct acpi_mps_check()
in following patch.

Thanks,
Petr

