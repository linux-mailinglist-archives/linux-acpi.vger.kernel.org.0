Return-Path: <linux-acpi+bounces-15622-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E8EB234C5
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 20:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEA23BD618
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 18:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC82FF169;
	Tue, 12 Aug 2025 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpAgImkj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8F2FF15F;
	Tue, 12 Aug 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023948; cv=none; b=jjRk8sWKjhqU6XcWubPYxIAS8f++hHfsg1E0R2gWTAv/1FE+43r53qI+OUb3PoJhDD1muyPpp9FqvtEJN/h1T6kP2Nk31gCpd+Lw7t58UwBp7ZNKh5aRRDJKuLjAnNSpyRqNKZIW4m0ghcPW2EH2zTIzTulqNipTklDD30NDOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023948; c=relaxed/simple;
	bh=h4IHvbxF8k2yAG7hbE3pb3p+/1nKFYweLsVeG1iW4xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEHUbcfVgkrcaVqtPiyHaUNDBDWU50ZDSJPQmDUeaMvDRwkB4zBhAZkIG5+rcn6oMpZQ1Y8YWW0DrTNZoQG28QRzuJgbxukgc4PpuHDgt3yzjnMXjlYDIS1hL949KIgpLS3WNL6GGgmaAD16KU6rxhy8T181j54SUo+zrwMDp/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpAgImkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE732C4CEF0;
	Tue, 12 Aug 2025 18:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755023947;
	bh=h4IHvbxF8k2yAG7hbE3pb3p+/1nKFYweLsVeG1iW4xA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KpAgImkjUFtX3a2kVXvOBbn3oky0F+wwimDMqPbVbMoe6zbUofrAtN3YNkUL8Xi8u
	 RyQjUgrQjlgSBPFP+DaRHQZF0baEQW/aCMXa0wHLITIJITpO5wTrJzYyqHlUbMxIWd
	 C3Ky268oWBY9NBLdzjdaOTmMWZoD8PlKSGyMvZYibx1xzsp6dLui21Xu2P8RcWCsZ7
	 Ya3kYLD/AorhcPcr6kHBnNN01BnfWuHtM7oEDTbUwA/FdZH3ya9H44vYmEBz70UiPZ
	 CighVNowSaWmQFE9/np8rn/ZN9qKY+tSgS+1IFKkVtCXS5/B6dlhlSwe/lfaOjrVVH
	 nHFcr4xul1fxA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61bc52fd7a4so104281eaf.0;
        Tue, 12 Aug 2025 11:39:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvfJRQkpkxyW5uu1t4WXKREAdUd3ThCtq3LQLLp54HKBUuSYgIvC4OzyQ5ijDrRx3eHAXsBw8OXzoW@vger.kernel.org, AJvYcCX4XMb4FP/GtS9x2gkLp1EvspjoXU+BdxYrfu+WWfu7zwMcaaUUrs0WSbBTNGtIOFM0735Ze0BM@vger.kernel.org, AJvYcCXz9vwWqEPlCQjkHmPfmWJ2wvfKux+BiJAMzo+EC848szHi9vIIGdK21zYOZKawS9ATbROz9Er36vYdEapq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4RhV1eZJaOJnTW3L9Ijnc4XhUqORnty4Tci/6AgmsmtnQk/L
	v0ETcCw4m8n7s3oEni7Y1IjbhOQRKNaDeOHBHZR0vgPz58AyaUP97vYFa8uWMTZELxKjSvZJCUz
	6Gy1kqGrUxDr0PmI/XHtZEFFTiw63xy0=
X-Google-Smtp-Source: AGHT+IF7F7E6Q/yD4mAd/nmxOeXMAZ9gG5D9aCHWydD1kXkZKoLffiBxSjbg30syn9qXivZlss/Bunm8AuD75hlQt1Q=
X-Received: by 2002:a05:6871:8217:b0:30b:b4cb:936c with SMTP id
 586e51a60fabf-30cb383108emr507207fac.5.1755023947056; Tue, 12 Aug 2025
 11:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729062038.303734-1-W_Armin@gmx.de> <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
 <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
 <d8c3432f-dfb7-4263-a556-2d93f22e618e@0upti.me> <2025081246-raft-tattle-642c@gregkh>
 <4e610854-d84c-4a59-9f83-422eafb40d6e@gmx.de> <2025081227-humpback-garden-7a4b@gregkh>
 <d51317d4-92da-4617-970d-6a63236aec30@0upti.me>
In-Reply-To: <d51317d4-92da-4617-970d-6a63236aec30@0upti.me>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Aug 2025 20:38:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iNYh5=0e+rdDPOfSMNH1P=g+NWWHa28ajf4_Mr6e26VA@mail.gmail.com>
X-Gm-Features: Ac12FXxx2IsAmOw1yEab040KAvsDdaQ8JpCQ8ZtH9-S3fKCFYLA2zQDDIB50YYI
Message-ID: <CAJZ5v0iNYh5=0e+rdDPOfSMNH1P=g+NWWHa28ajf4_Mr6e26VA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
To: Ilya K <me@0upti.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, Armin Wolf <W_Armin@gmx.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 7:57=E2=80=AFPM Ilya K <me@0upti.me> wrote:
>
> On 2025-08-12 20:10, Greg KH wrote:
> >
> > Please read the above link for the full details on how to do this (hint=
,
> > Fixes: will not do it.)
> >
>
> I might be missing something, but doesn't that just tell you to CC stable=
@?
> Or do you have to specifically have the CC on the initial patch submissio=
n, not anywhere in the thread?

A Cc: stable in a patch (or elsewhere in the thread following it) is
just a hint for the maintainer anyway.

But no worries, I've added Cc: stable to the commit.

