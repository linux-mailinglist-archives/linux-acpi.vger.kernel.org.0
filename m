Return-Path: <linux-acpi+bounces-20830-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDwUGwDWgWkCKgMAu9opvQ
	(envelope-from <linux-acpi+bounces-20830-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 12:03:28 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7197D80E0
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 12:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67B14303F045
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDFA326948;
	Tue,  3 Feb 2026 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoqSX4bS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC03164D3
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116605; cv=pass; b=j6preuwrBqosqKn09C1VPqvgoDeLcMOuC9tpcr/IqWLj9CLvW7cnJRZSHRo1DxbINRI4IyMOWcVJqgZpBWn53BREDnmfLi8egKWU7kh1y5fZaHdjG3t/r5a1DieZmmaQ19/EMs1I/AZuQTlu6UeGEn1Tgz+WEY543N51YJjIXRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116605; c=relaxed/simple;
	bh=UkNMgpktyLGxh/cFTtfeZZZty1SnTeDWasdVswM1t1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/8FKD2gs7LlxU22RJPXThJ4X9RU2m5bXJDH9HVgbjHqxOufsiHT+kjj/bccaikNgaPAAkkVvHgyvJ5LExig6XWsT3HGAzcnyyf4obY+khd15t6hn0lYM/JBUTwfEOeqM3ywjhhGuKgnUw+D0vc9ComgKyOSVXO9Is+tZHshQiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoqSX4bS; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d1890f7cefso4488077a34.3
        for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2026 03:03:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770116602; cv=none;
        d=google.com; s=arc-20240605;
        b=BDFgJ1Q8WZGxQsMYGO1pCQK0vUJ/nuGj8wyaCi6dfnlpGYcbDBa7syOjQepk5X58hw
         hP97O26gVQzneTBDYfFJg6AOIWVe1H09mWny/6DkKBpw7H1dYuUewd+qOar3BcIiKLxn
         pFOC6Vrwc9aFfANbK+gsevI4JsJIPNBDKJhjSKtgQJYgGMKZPtCF9o0ewbiqelY4wmNP
         0mnfKe16RRdqkxfkwHr26puSFDwUxzRP7mJ+QE46YTk0zfe9im9mjJ+WKKO0yL4o8tdF
         JXQEUdnhUS0DlV1luPVEl01c4mUPVYkiv+veZmLuPaQ+tAJrNxa/Ud7xiSRxiSADk3JQ
         zA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h/fgvm9k9I3pQj36j4/Ol8L8Z8tktEJAYn/oo6tMALo=;
        fh=MKdxQ/DtqROO/3/ztqv95N3cfGwW02mcyKudsVdXa/4=;
        b=lB7WB0rMbebK4dt0ee/MgyyB5oDi1EG8T4h7+YnQnmBA3Z7NDbS8tSgHWoIfv0C31Q
         UHTTA7Vz4J1YnWx28I/gYk3LWIvasF8/5RwRPZxlZmRMgrcY4v4vVCWkhn9a6M/Dap5e
         WIm3G0I1gFj6M/y2qkKQonnNc4Aug1jEd75amJ3wWhk0OqylXWzB2WrOFMb+cvDQLMDn
         +u4uFHOGjIPnbU73/IBpagIfkiQXDgJ1aKnad6le5aTIT+e4uEWUbbSZ5mAlUgMIvf84
         N2LBbaSQggGpp9CnFDM07jU+fp+Vouk15Om7Sp+z+wZW2uQCW1Cvy+r1jPYWYxcYubUw
         /eDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770116602; x=1770721402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/fgvm9k9I3pQj36j4/Ol8L8Z8tktEJAYn/oo6tMALo=;
        b=NoqSX4bScv6ecO5bvbh2SbdlA8mf0f8uNziBC/8GxEsINC5qRXDXuI64Ifcfqc3nXj
         s9iMtdxuYxdxAlybKLkDNQRMEeUBNcbo4K1gThNJuO7GFZeC4TtC5vcNpayxYgkgQmY/
         AO78oXobhoFHEyzkcdBVYeuJVnNmaMUldxD9vBYqW64iVTLK6cr+kkkMYI5y0Ry67z+G
         vYOLMrIYMqp9KLYo9e4a8xnnbaxp4n5IDGJBER/PT4WV8nsCLQS2U90mWtPfRo328/qw
         9TvKHri6n14CLux0p+iQvwY6Lslg0wAkBIaO2sPt2zPn0+Odkh1zb96TzRDnxi0i3lzH
         uz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770116602; x=1770721402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/fgvm9k9I3pQj36j4/Ol8L8Z8tktEJAYn/oo6tMALo=;
        b=uWgGzyCH6zajKK/Vs5cqZulpnBOW01gXPEg/BrRqH3HbqE16Xd+uSK3Efw9XcjksiM
         L8Wbj7pzBmQvLePEdWvxsgasbi6Hns6wOdP+IYQKh0jv6SGz8dUQACT8CaeMTMWF81Q6
         YZGZp5I6eoY7ujCInD00TCyPK9bD0fdAiTcdI0mVb06wqoPQ7hXNE5mRVQaDEwv8z50e
         evMFhk5a/sNI6/s1VSPxq6VsAjn4p6RsVBCl2puPK4Bi/XCAKU+8fj/EoEXLw+NoJmBl
         x8JhpYqMHymA/IKlB6+BbJcxoDWzPuch5575iOWf104g63UtcSS/6kNA2IfVpbIK376S
         Ljcg==
X-Forwarded-Encrypted: i=1; AJvYcCUsVUIfR4TwdasQP6pPSbaoeeCWzSbrJbbThMINuokTwq1UEjUPLeqTFMHmfvveWOv3kO6/9RD4BYpz@vger.kernel.org
X-Gm-Message-State: AOJu0YxbwaFyV2yAvHKYmsc1xT9UgkwwLA5K6N7tUvVvFAVCMVWdOyMQ
	R6QwFtdkpNb6tCLMqFYjBBDR5Dr7Ql66NtH3jFahDGtRTtqacSEH/t3To5tWFWUDF36Z9/dSQCk
	zMLCqCkrLmsqZKh9lOJftsRUzpqMCJBw=
X-Gm-Gg: AZuq6aI5wKyq7qgmTIY01S5W1hN1o680Qc/PbxN3BzA1Os2L60lCotvDPKpeA1+k0Yj
	ik8V4j4ddt/NOprDYvp9yuzM3yCOf5qDfexvjAGCv1eF5w8pFa0xqVAPpXT7M4X+PzCStzDp3oW
	45EBkC4xztVQIQx6wJMv7DTptX/4DEyHIGkLBEp5lC6jiwslMU9rgmLDSLTR/5InxK/PgUebFuY
	CM1F1fX5fYxvORhOcF+6Z4FQIknbLyKAsT0rCJX+6QMa+yCI2lfid+XOn/6PWvTnMzUS2UN1+fb
	xr+dCAdffeSEGnrr14TochgnVh0NkQ==
X-Received: by 2002:a05:6830:4129:b0:7cf:e4a1:8a9d with SMTP id
 46e09a7af769-7d1a5297c29mr8159047a34.14.1770116602510; Tue, 03 Feb 2026
 03:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201130334.3107-1-sef1548@gmail.com> <20260201130334.3107-2-sef1548@gmail.com>
 <20260201224801.609e94d0@pumpkin>
In-Reply-To: <20260201224801.609e94d0@pumpkin>
From: Nick Huang <sef1548@gmail.com>
Date: Tue, 3 Feb 2026 19:03:09 +0800
X-Gm-Features: AZwV_QhdUgCdkKepFW4cAvOKDupDDsaAd1xiSEssbfuI1gzYSGsQjtdmNg1EZyE
Message-ID: <CABZAGREQwVUfRQkkTTXUYD_Uvkf0Wxa=dj7r_r85vMsTnUn67A@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIEFDUEk6IG5zcmVwYWlyMjogUmVwbGFjZSBPKG7CsikgYnViYg==?=
	=?UTF-8?B?bGUgc29ydCB3aXRoIE8obiBsb2cgbikgc29ydF9yKCk=?=
To: David Laight <david.laight.linux@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, paladin@ntub.edu.tw, kusogame68@gmail.com, 
	ceyanglab@gmail.com, n1136402@ntub.edu.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20830-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,vger.kernel.org,lists.linux.dev,ntub.edu.tw,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sef1548@gmail.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7197D80E0
X-Rspamd-Action: no action

David Laight <david.laight.linux@gmail.com> =E6=96=BC 2026=E5=B9=B42=E6=9C=
=882=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=886:48=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Sun,  1 Feb 2026 13:03:33 +0000
> Nick Huang <sef1548@gmail.com> wrote:
>
> >    Replace the O(n=C2=B2) bubble sort implementation in acpi_ns_sort_li=
st()
> >    with the kernel's sort_r() function which uses heapsort, providing
> >    O(n log n) time complexity.
> >
> >    This improves performance for large ACPI package lists while also
> >    reducing code complexity by leveraging the existing kernel sort API.
>
> What is the break even size?
> While the heapsort is O(n long n) it is also more complicated.
> There is also the cost of the function call - especially with all the
> mitigations that distro kernels are likely to enable.
>
> For large datasets the d-cache locality of both sorts is particularly hor=
rid.
> It is almost certainly better to allocate an array of index:value pairs
> and sort that.
> For very big datasets you want to sort small sections (that fit in the
> d-cache) and then use merge sorts (also O(n log n)) to combine them.
> (Yes - this is how you sort data with 3 mag-tape drives....)
>
> Oh, in any case, write separate functions for ascending/descending.
>
>         David
>
Hi David

  Thank you for your reply and the detailed feedback.


   I ran KUnit benchmarks to investigate your questions.


   =3D=3D=3D Break-Even Point =3D=3D=3D


   I compared bubble sort vs heapsort across various array sizes:


     N  | Bubble(ns) | Heap(ns) | Faster

    ----|------------|----------|--------

      2 |         61 |       99 | bubble

      3 |         63 |      115 | bubble

      4 |         78 |      163 | bubble

      5 |         96 |      215 | bubble

      6 |        119 |      260 | bubble

      8 |        177 |      388 | bubble

     10 |        257 |      539 | bubble

     12 |        415 |      721 | bubble

     16 |        726 |     1044 | bubble

     20 |       1106 |     1484 | bubble

     32 |       2854 |     3091 | bubble


   Bubble sort is faster for all tested sizes. The break-even point was not

   reached within N=3D32, which covers all realistic ACPI use cases:


     - _ALR: 2-10 entries (ambient light response)

     - _CST: 2-8 entries (C-states)

     - _PSS: 5-20 entries (P-states)

     - _TSS: 2-16 entries (T-states)


   As you noted, heapsort has additional overhead from function calls and

   mitigations that outweigh its O(n log n) advantage at small N.


   =3D=3D=3D Separate Ascending/Descending Functions =3D=3D=3D


   I also tested combined vs separate sort functions as you suggested:


     N  | Combined(ns) | Separate(ns) | Saved

    ----|--------------|--------------|------

      4 |           84 |           75 |  11%

      8 |          179 |          175 |   3%

     16 |          737 |          806 |  -9%


   The results are mixed. Separate functions show marginal improvement at

   small N, but the combined function performs better at N=3D16, possibly

   due to instruction cache effects.


   =3D=3D=3D Conclusion =3D=3D=3D


   Given these results, replacing bubble sort with heapsort would likely

   degrade performance for typical ACPI workloads. The existing bubble

   sort implementation appears to be the right choice for this use case.



--=20
Regards,
Nick Huang

