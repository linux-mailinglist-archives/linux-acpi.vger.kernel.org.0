Return-Path: <linux-acpi+bounces-13342-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 415A1A9F9DD
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 21:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B5B4654B5
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D91028F92E;
	Mon, 28 Apr 2025 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6WrQSo0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB926AAAE;
	Mon, 28 Apr 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869540; cv=none; b=OkzXl/T3zSsJho8YiNpr8t1K2voWwCuwaCWUClrHJw7DV5m5NsY3jBFvHjTKtZoyFFZPOubnVYiq/JRe6Jx0VXLdN9Ot7UNEW8U5LhD4G9/CBGeR3mj5zd9LDzez/vB/m84JNx05no8ryKZGjgkzFGfWcZvwqwT+3eXBKSu3Gis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869540; c=relaxed/simple;
	bh=NT26u9oFRj65rxO+ZMUCrwxd7/h7nvkV5DOD1q0z6Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVBotiiGigNSkUJPruofNSHrqw7G801NhYWiAEwcrJ0yqt0ALNjrXyWLhb971ShtUzeVU99pPkTYFH1CCE2YM0MTuidCl9BuNH/SF3l49Rkqw8C6zd5eOgNK3wy0EF5PnPo7mfPtMgpsFioD4CINTCB9qPLXdkJ/wcqQCuYEZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6WrQSo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5EEC4CEE9;
	Mon, 28 Apr 2025 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869540;
	bh=NT26u9oFRj65rxO+ZMUCrwxd7/h7nvkV5DOD1q0z6Uk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n6WrQSo0mDYO2BmJ/xTKvNMQsK0t+qnkkrDu1zxtVHoXiHJy1hfTb2QVEfFjHumAq
	 MaVOqkV9+sO7WVfMDaQAUkpnqS9OCj1n1y64NKMiYSUB+1LqJkD+0BB5tqesQWU/2R
	 CGKM6wS53s5tbsPc2pmnemMq3HNSCw84CB/qtMUjYL5XVCNIZhnpypqYQ4HvZay1h0
	 JHwLnBTblwtLUvs6wTDGRNtYImLfhAG9YdSJ37oTmBWl690olj36Jj9SSrQN0bf1IR
	 w8CQ9fx5Xz9jcPx9zSOLkVknSLhLRb0H8nqcsTlRd3ZljJ2lMSu4UHHI/KA8fJ4i2t
	 TGDHQ6GGJFNIQ==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72c27166ab3so3966980a34.1;
        Mon, 28 Apr 2025 12:45:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQhQO0kBMsjVUKuAtYZtKYK93y5R0+YJ7dTS8rxG11AgSa8iqAoU/iOm7UTTIc6Zh6KMVnlTdMf0Fhyw7y@vger.kernel.org, AJvYcCWcnT6d3X/eCEk1B6oLhtQiRq3fG5mI2UJr4wS+gTZK/yytQ24SWinRAuC8QlvMDYCpcMz+jrTu663u@vger.kernel.org, AJvYcCXhHWNp7qAeji5vJlQE0vnBPCEL/HFs+hVYs2UWg0fCu3gIl+mjDbZBoWVQaprrDFMMGV+8MPvumNGZgJnFi8RFyRUCEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNumBe21IoJiAcjngfA+oG7Hi+5BbgTEvdaWNO6ntMrxDqwz8
	DoDY0HQQxm7+5OwcxZO8yJ5vGvYikpfVOpfKXcKWNld9dEvJCzL5ZF3f9JPML/ZaRbw8thlcB+D
	lNL52wRuq6TJ5rwLsyRenCp1W2+A=
X-Google-Smtp-Source: AGHT+IEsmvIFQExkncL6gycgIBu8zSEPZ/8VWq1+PlGbN8TFyLeEuLv29h60qdPiF8wAsDd9s8/GnF0hheeDyUduKVQ=
X-Received: by 2002:a05:6871:4d0:b0:2c2:5639:3a4d with SMTP id
 586e51a60fabf-2d9be93a4bdmr5608840fac.38.1745869539594; Mon, 28 Apr 2025
 12:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5dd019ad4506.2100bf0f83374@gmail.com> <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
 <b6fc4e66-b35a-41ce-a633-db3d660b88a2@amd.com> <106bd256-2c08-463f-8498-b68f2d5ccaca@amd.com>
 <9de18953-3f6d-447a-8274-c953bae64039@gmail.com> <a2747306-447c-432a-a926-e9d0473d9a0e@amd.com>
 <CAJOrcgV-5tr66YbDd_mCL00YHg7nPVdJUon9Az7pZQXpNtwUoA@mail.gmail.com>
 <e8129e3c-aba9-427e-ad63-bc1ea1bdf0f5@amd.com> <CAJZ5v0jS+gdHqW3pB1awZ7LHHWsFBQMp86tNwPMVBzOfot-sZw@mail.gmail.com>
 <369d0a74-4d5d-40e9-aa87-86c7563cf019@amd.com>
In-Reply-To: <369d0a74-4d5d-40e9-aa87-86c7563cf019@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Apr 2025 21:45:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i9ZKgybAarKD0DDH1q6k1LKse+kX=Op94zGO+PjyMvGw@mail.gmail.com>
X-Gm-Features: ATxdqUG61rWbjGHgrQrYUCkddXMoTUmVKBj0BSqBqy3dlL9hVPMflxlj4fcyRc8
Message-ID: <CAJZ5v0i9ZKgybAarKD0DDH1q6k1LKse+kX=Op94zGO+PjyMvGw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms
 after suspend/resume
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Marcus Bergo <marcusbergo@gmail.com>, mark.pearson@lenovo.com, 
	linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 9:11=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 4/28/2025 2:02 PM, Rafael J. Wysocki wrote:
> > On Mon, Apr 28, 2025 at 8:23=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 4/28/2025 4:51 AM, Marcus Bergo wrote:
> >>> Yes, it does.
> >>>
> >>
> >> OK thanks for confirming.  Considering your finding with this patch
> >> you've shared and knowing there is a timing dependency that delaying t=
he
> >> next s2idle cycle helps I do wonder if we should keep exploring.
> >>
> >> Rafael, do you have thoughts here?  Specifically do you think it's wor=
th
> >> revisiting if b5539eb5ee70 was the correct move.
> >
> > Well, it was done for a reason that is explained in its changelog.  I
> > think that the problem addressed by it is genuine, isn't it?
> >
> I mean yes - of course.  My inquiry was whether this should be the
> default behavior or if it should have been a quirked behavior.

I believe that it should be the default behavior because the EC GPE
needs to be cleared after handling an EC event which effectively is
what the suspend-to-idle code does.

> I don't have a good sense for the rest of the ecosystem what the impacts
> would really be at flipping it.  Would it be worth adding a module
> parameter debug knob and survey what happens on a wide variety of machine=
s?

Maybe, if you suspect that this might be a widespread issue.

