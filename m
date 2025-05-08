Return-Path: <linux-acpi+bounces-13647-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F45AB02AC
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 20:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A087B2488
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A6A28314E;
	Thu,  8 May 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0vX34Bv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6353281363;
	Thu,  8 May 2025 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728797; cv=none; b=bM0Ju1DoRnZzGaLbwXQMoDJyoxZQPJe5BSIa4qig8YhnGtPAknmIlcEN5HZ0KuexUupYszCf+OPxwsGqbu+M5AoGanaa4T0ov0/nRB2nGtQr8qdQmSBJdVwwuDbUXu/H1ygeXAIU6rTIEKznSvU4o/cHJpqyjDhNE+fO9bO4ktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728797; c=relaxed/simple;
	bh=TV/DfA1+9HMKHUzT+UR/gakV4+uuJ2aHJxXt+sNWNpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WC6gCe1+xZPm4I3Y0pZWF7dbzlmTJVJgSa35ec6gS3dGb4Sj8IHLGU/d9Wjz+y1szCG0FY9pfvAx8XozEo2IFayZsyWlZx/piAZeqhV1OR5sI1t2+YQzc1Lfo1yaDE5DdXlOPCs/HJRAtAPs6VpudKXQPvPNbpjYWDonhLPTdJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0vX34Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53773C4AF09;
	Thu,  8 May 2025 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746728796;
	bh=TV/DfA1+9HMKHUzT+UR/gakV4+uuJ2aHJxXt+sNWNpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W0vX34BvhqERisc9pPDTrtpEzxpqUU7+fjntYQSiYl1vgqIrS7y455J4HVkP4tMiE
	 9S5EC67d43f8FD2n3FGNXqXBY33xhNi6k5PiFNkIZ3S7GYaaOiwB88EmBPJYoSuo4p
	 45+EwZUJPIyNEQBK2ZJwt6c/dPEW23FK1TWscFMq62I4dR5kl8r+pts0mDEUDiM9nR
	 Aitf1znG+IiXkMTe6jqPCcMgPfxU3Nf0EfsdT5hMCNnpEQmloLPMm889X9nCgsz4pu
	 99SJP0j5KjxL1DmNxwrJT8AJTAPYx8rAyriWW1hx5JXsMaywvQ9eDal1G8dUvBP0yL
	 Iw3l+zBJiDN4A==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c7336ed99so400502a34.0;
        Thu, 08 May 2025 11:26:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhho5o1o7dDGGNx+FdfpQ9tS3eFhzM1HGKfxSzIK+mEVFF+2gIIFnoI5hqjb2uEJfKylbtXhEiI2GFtA7X@vger.kernel.org, AJvYcCV2TFowXXW77kIyynry+sreFJMZcQrK/8Ls7TIBchJlmRgR9eAtaCL8Clk2rS3SW307lNu+hLc9Y+My@vger.kernel.org, AJvYcCWbTKAnTxVFUpEF2InJu5OicVhb0oK1TFN1m0VPmxvSMhJFb5lzo7TopzcHqE6agymM1NzIRG8G@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9B4j6vvYmjL5KTi3e5FV+kMpQAdfUnA8n+30T3zz6ToOjL0y
	/fGnBFXLksRt0SdNvunZ6CyoY5lb2mx82cpn1rysJfLIXH706L6CCr/KnhPCYjH1+LZ3HWm9oXR
	xnN0tjUYa9qcPxgbo66MbUIAo7v0=
X-Google-Smtp-Source: AGHT+IF2Nf5Fasy7Qu/XU0O/UO9AwN3maQCBaHAFkTPwDHkgmNIXFD8BqrcDfV+OFXwTKgnDslsqpJLbbTA5+Cs/0HQ=
X-Received: by 2002:a05:6830:6611:b0:730:da:1165 with SMTP id
 46e09a7af769-73226ae9d31mr741954a34.21.1746728795645; Thu, 08 May 2025
 11:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508023025.1301030-1-jeremy.linton@arm.com> <20250508-abiding-enigmatic-mustang-ab3bd2@sudeepholla>
In-Reply-To: <20250508-abiding-enigmatic-mustang-ab3bd2@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 May 2025 20:26:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jOmeKy84N0My7o+PvAybjdaxv9ZS8HT=X0momY7rzTuQ@mail.gmail.com>
X-Gm-Features: ATxdqUH9Pj_neQFHcxXdnSIxaBpGj_wzwhGGHZ5DpVN043u7sQCsmcbIF9wohLs
Message-ID: <CAJZ5v0jOmeKy84N0My7o+PvAybjdaxv9ZS8HT=X0momY7rzTuQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PPTT: Fix processor subtable walk
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>, rafael@kernel.org, lenb@kernel.org, 
	jmeurin@google.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maximilian Heyne <mheyne@amazon.de>, Yicong Yang <yangyicong@hisilicon.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 11:13=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Wed, May 07, 2025 at 09:30:25PM -0500, Jeremy Linton wrote:
> > The original PPTT code had a bug where the processor subtable length
> > was not correctly validated when encountering a truncated
> > acpi_pptt_processor node.
> >
> > Commit 7ab4f0e37a0f4 ("ACPI PPTT: Fix coding mistakes in a couple of
> > sizeof() calls") attempted to fix this by validating the size is as
> > large as the acpi_pptt_processor node structure. This introduced a
> > regression where the last processor node in the PPTT table is ignored
> > if it doesn't contain any private resources. That results errors like:
> >
> >   ACPI PPTT: PPTT table found, but unable to locate core XX (XX)
> >   ACPI: SPE must be homogeneous
> >
> > Furthermore, it fail in a common case where the node length isn't
> > equal to the acpi_pptt_processor structure size, leaving the original
> > bug in a modified form.
> >
> > Correct the regression by adjusting the loop termination conditions as
> > suggested by the bug reporters. An additional check performed after
> > the subtable node type is detected, validates the acpi_pptt_processor
> > node is fully contained in the PPTT table. Repeating the check in
> > acpi_pptt_leaf_node() is largely redundant as the node is already
> > known to be fully contained in the table.
> >
> > The case where a final truncated node's parent property is accepted,
> > but the node itself is rejected should not be considered a bug.
> >
>
> Thanks for picking this up and describing the issue properly in the commi=
t
> message.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Applied, but it is a bit too late to push it for -rc6, so I'll queue
it up for -rc7.

Thanks!

