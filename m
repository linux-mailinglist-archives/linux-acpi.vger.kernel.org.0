Return-Path: <linux-acpi+bounces-13605-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098E5AAE74A
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 19:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86AF3B16A7
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3423020B7FC;
	Wed,  7 May 2025 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwAs/lJs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9E10F9;
	Wed,  7 May 2025 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637293; cv=none; b=cA0fcXMJI7IWg1mubl6zJHUKaf1LdY9rXusVFyxkBbnv0ef8oYrKW4VM5LIS2iXn21TNzpB0q9A1PYXUYafohGWrjNYYTErg09VgG0ao/WytanUnke0LKiuTvPm291JXJzTWcV/LevdQEH8GMAg08slZ7jv+GxOFXP4fHIkcWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637293; c=relaxed/simple;
	bh=WWF4HysMWVfjRQkCh0ajdFTLwnPc+5TrfLe/aMyFw5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utHPSZtU6jFSNF8pdn4Fh033gc9PRekavuPH5meZPKWdHgCzC83hNOhe2PvOLt9XBQTB8wbir+wEXnPUYV1VgTDnl3p0jxggeM7RpunhHUep2VGQ4C/QUAVsF/6lpeBVFzKu57rOfBOGJliossNmi9sowhy+To9ePXcoA0pAKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwAs/lJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F567C4CEE2;
	Wed,  7 May 2025 17:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746637292;
	bh=WWF4HysMWVfjRQkCh0ajdFTLwnPc+5TrfLe/aMyFw5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rwAs/lJsP3feSK41EI/+IJrKoBq3J0paf1KGCtW0KFqkjUrpAO86owcoVFlaDIi3R
	 M7QTbO37SgTBJYXaPsd1no3k+ST6CvLOcOKoKUCdmP7NEQoaH/pEuETCAGXYyBPcUC
	 Q3pazwOqPKRB9w1R4ziKZAXlYs2DpCuFlYaW/619ueGe/9OQEaibUBLmlK97FrwvIp
	 NyB7RkPMaCgqE2X1DCyjovgKki/fGb8QF/rcH8ymkP4kT3BgQqi492eN5tysKRkjtq
	 6vwzPtBKfO0qKGUvZM26PShE5wHo5saWKTE98V5ITpHfuyU0WsCroV2mzkViR0bhuQ
	 JCwcQDYp5o0Ow==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-60657f417c4so63435eaf.0;
        Wed, 07 May 2025 10:01:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVwLl6E16N5QiEZVcpxD/C20Nn+KfM7Ah/LcAlN1Xwk9Wd6raU9C7D8zL1dXloj/ALDNZI4NIJeNDs@vger.kernel.org, AJvYcCX3rWtGHB1XexOHD7PuSaWzEGzyXNd2bUDsnCy8x+L1wFAhIUS1vwfAerfC8RpYZyrsRjcfguUkHW9iMNdN@vger.kernel.org, AJvYcCX7rAsNHWQ6FphUzspP87LTTfvrPWHZZZHrFWBVXYUaOmFekNeeRqaBPByLLZt7hRNrdWTPygwr@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBts/x5kaS80atJaN4mT9CvnfgTYE1PHYHdGEqb9eNmciyrUz
	ZF5ptXrYvwi7mnRORyLjvLOVFD1f1h25rKmG18KzxNwgAlr//YMQ/BMFYhHxjse7+5E0SL5uIao
	bxWUtQYWXkbNKsoMKcjvNRuK2X6s=
X-Google-Smtp-Source: AGHT+IEyp/1fcrvYo1wiJbYwnxAXqyA1M8IBw+kq9UcquXiy2i3G2TRZtYTxsV5Li6WT+9Jw754gnHQZ+F4nHbzRwE8=
X-Received: by 2002:a05:6820:198e:b0:602:5856:255c with SMTP id
 006d021491bc7-608339b7e25mr51774eaf.8.1746637291743; Wed, 07 May 2025
 10:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-draco-taped-15f475cd@mheyne-amazon> <214c2a2d-e0ea-4ec6-9925-05e39319e813@arm.com>
 <CAJZ5v0jvWXDQQ++4wmWJ+i=jds+MZ68bRB9+26WM4tAPHFxALw@mail.gmail.com>
 <1911d3b6-f328-40a6-aa03-cde3d79554de@arm.com> <CAJZ5v0ii9HLfqfgcp=1qRRX6M1yThf7ZPNkSLVc5GGFhv=N-Lg@mail.gmail.com>
 <ad04d07b-d610-4355-bd47-1d2fb49711f3@arm.com> <fb2e3c60-1171-4f5c-852d-a5bfdc4f9c2a@arm.com>
 <25aa77b9-0077-4021-b55c-e94327b7847b@arm.com>
In-Reply-To: <25aa77b9-0077-4021-b55c-e94327b7847b@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 19:01:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hTiJSp9q4iWu_EHB47X3Bf9LFY+ZZoqm7aN0cD8Jnjvg@mail.gmail.com>
X-Gm-Features: ATxdqUFO6gzxkrZPQ3np8CtDAhbK6am2XgaSiVd7edj5CqwnaeVom0pEB4NLGNg
Message-ID: <CAJZ5v0hTiJSp9q4iWu_EHB47X3Bf9LFY+ZZoqm7aN0cD8Jnjvg@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Heyne, Maximilian" <mheyne@amazon.de>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 6:41=E2=80=AFPM Jeremy Linton <jeremy.linton@arm.com=
> wrote:
>
> On 5/7/25 11:38 AM, Jeremy Linton wrote:
> > On 5/7/25 11:31 AM, Jeremy Linton wrote:
> >> On 5/7/25 11:12 AM, Rafael J. Wysocki wrote:
> >>> On Wed, May 7, 2025 at 5:51=E2=80=AFPM Jeremy Linton <jeremy.linton@a=
rm.com>
> >>> wrote:
> >>>>
> >>>> On 5/7/25 10:42 AM, Rafael J. Wysocki wrote:
> >>>>> On Wed, May 7, 2025 at 5:25=E2=80=AFPM Jeremy Linton
> >>>>> <jeremy.linton@arm.com> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 5/6/25 8:13 AM, Heyne, Maximilian wrote:
> >>>>>>> Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple =
of
> >>>>>>> sizeof() calls") corrects the processer entry size but unmasked a
> >>>>>>> longer
> >>>>>>> standing bug where the last entry in the structure can get
> >>>>>>> skipped due
> >>>>>>> to an off-by-one mistake if the last entry ends exactly at the
> >>>>>>> end of
> >>>>>>> the ACPI subtable.
> >>>>>>>
> >>>>>>> The error manifests for instance on EC2 Graviton Metal instances
> >>>>>>> with
> >>>>>>>
> >>>>>>>      ACPI PPTT: PPTT table found, but unable to locate core 63 (6=
3)
> >>>>>>>      [...]
> >>>>>>>      ACPI: SPE must be homogeneous
> >>>>>>>
> >>>>>>> Fixes: 2bd00bcd73e5 ("ACPI/PPTT: Add Processor Properties
> >>>>>>> Topology Table parsing")
> >>>>>>> Cc: stable@vger.kernel.org
> >>>>>>> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> >>>>>>> ---
> >>>>>>>     drivers/acpi/pptt.c | 4 ++--
> >>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> >>>>>>> index f73ce6e13065d..4364da90902e5 100644
> >>>>>>> --- a/drivers/acpi/pptt.c
> >>>>>>> +++ b/drivers/acpi/pptt.c
> >>>>>>> @@ -231,7 +231,7 @@ static int acpi_pptt_leaf_node(struct
> >>>>>>> acpi_table_header *table_hdr,
> >>>>>>>                              sizeof(struct acpi_table_pptt));
> >>>>>>>         proc_sz =3D sizeof(struct acpi_pptt_processor);
> >>>>>>
> >>>>>> This isn't really right, it should be struct acpi_subtable_header,
> >>>>>> then
> >>>>>> once the header is safe, pull the length from it.
> >>>>>>
> >>>>>> But then, really if we are trying to fix the original bug that the
> >>>>>> table
> >>>>>> could be shorter than the data in it suggests, the struct
> >>>>>> acpi_pptt_processor length plus its resources needs to be checked
> >>>>>> once
> >>>>>> the subtype is known to be a processor node.
> >>>>>>
> >>>>>> Otherwise the original sizeof * change isn't really fixing anythin=
g.
> >>>>>
> >>>>> Sorry, what sense did it make to do
> >>>>>
> >>>>> proc_sz =3D sizeof(struct acpi_pptt_processor *);
> >>>>>
> >>>>> here?  As much as proc_sz =3D 0 I suppose?
> >>>>
> >>>> No, I agree, I think the original checks were simplified along the w=
ay
> >>>> to that. It wasn't 'right' either.
> >>>>
> >>>> The problem is that there are three subtypes of which processor is o=
nly
> >>>> one, and that struct acpi_pptt_processor doesn't necessarily reflect
> >>>> the
> >>>> actual size of the processor structure in the table because it has
> >>>> optional private resources tagged onto the end.
> >>>
> >>> Right.
> >>>
> >>>> So if the bug being fixed is that the length check is validating tha=
t
> >>>> the table length is less than the data in the table, that's still a
> >>>> problem because its only validating the processor node without
> >>>> resources.
> >>>
> >>> Admittedly, it is not my code, but I understand this check as a
> >>> termination condition for the loop: If there's not enough space in th=
e
> >>> table to hold a thing that I'm looking for, I may as well bail out.
> >>>
> >>>> AKA the return is still potentially returning a pointer to a structu=
re
> >>>> which may not be entirely contained in the table.
> >>>
> >>> Right, but this check should be made anyway before comparing
> >>> cpu_node->parent to node_entry, when it is known to be a CPU entry
> >>> because otherwise why bother.
> >>
> >> Right, but then there is a clarity because really its walking the
> >> table+subtypes looking for the cpu node. Exiting early because its not
> >> big enough for a cpu node makes sense but you still need the cpu node
> >> check to avoid a variation on the original bug.
> >>
> >>
> >>
> >>>
> >>> Roughly something like this:
> >>>
> >>> proc_sz =3D sizeof(struct acpi_pptt_processor);
> >>>
> >>> while ((unsigned long)entry + entry->length <=3D table_end) {
> >>
> >> Here your reading the entry, without knowing its long enough. For the
> >> leaf check just using struct acpi_pptt_processor is fine, but for the
> >> acpi_find_processor_node():
> >>
> >> proc_sz =3D sizeof(struct acpi_subtable_type);
> >
> > Although, maybe I just wrote code that justifies using
> > acpi_pptt_processor here because the entry->num_of_priv_resources lengt=
h
> > check isn't being made without it. So ok, use proc_sz =3D sizeof(struct
> > acpi_subtable_type) and assume that we don't care if the subtable type
> > is less than proc_sz.
>
> Sorry for the noise, scratch that, a better solution is just to swap the
> length checking in the 'if' statement. Then its clear its iterating
> subtable types not processor nodes.

Do you mean something like this (modulo GMail-induced whitespace damage):

--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -231,16 +231,22 @@
                  sizeof(struct acpi_table_pptt));
     proc_sz =3D sizeof(struct acpi_pptt_processor);

-    while ((unsigned long)entry + proc_sz < table_end) {
-        cpu_node =3D (struct acpi_pptt_processor *)entry;
-        if (entry->type =3D=3D ACPI_PPTT_TYPE_PROCESSOR &&
-            cpu_node->parent =3D=3D node_entry)
-            return 0;
+    while ((unsigned long)entry + proc_sz <=3D table_end) {
+        if ((unsigned long)entry + entry->length <=3D table_end &&
+            entry->type =3D=3D ACPI_PPTT_TYPE_PROCESSOR &&
+            entry->length =3D=3D proc_sz +
+                    entry->number_of_priv_resources * sizeof(u32)) {
+            cpu_node =3D (struct acpi_pptt_processor *)entry;
+
+            if (cpu_node->parent =3D=3D node_entry)
+                return 0;
+        }
+
         if (entry->length =3D=3D 0)
             return 0;
+
         entry =3D ACPI_ADD_PTR(struct acpi_subtable_header, entry,
                      entry->length);
-
     }
     return 1;
 }

