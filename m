Return-Path: <linux-acpi+bounces-18159-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274FC024B3
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758B9188CD7F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 16:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD71266B46;
	Thu, 23 Oct 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD3nbmvi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE82261B9C
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235317; cv=none; b=CAVDHq8Ykf+fLGKihkFIIDkALs5hCxh/8eZEVTs1TyOGjNJ9SCs3e6M636sXj0gfrfUghZ3E14/+V0U9A6uqUUUkKoGw9mnqylOPcoBlZ3zZdEncEz/UNJeBEL3FYEO8+PR1LF2I8vveDhIOuV6WTFT1liR46EaGsRXQO7CH/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235317; c=relaxed/simple;
	bh=0+JbNYp9OjiNwE8w+NF/xy7YhffXNXh52qvMJgHorlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY/nw6QN6/tOD77aIlYmsdC8X8NnA/zJcGbg8p7Ayq+xsKI/4kMTyyWG955banrGOqFaYgs395R/DgWuOuLIkY9ROStJ6sLyPQ0aMzcP7W7omeCy6alOlhBnYeLGwNam/8KYdsSyzGtRW8vYOeWePn2F3S3OCyCgeKQngnBHcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vD3nbmvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02E3C4AF0B
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235316;
	bh=0+JbNYp9OjiNwE8w+NF/xy7YhffXNXh52qvMJgHorlc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vD3nbmviBOHebz37IPOHRh+YXPZSDO2TnIhe5pnHRgR9rkFuvt8e3hPgAPPOAaIq/
	 LTZIztqGzNL2YFKZfykQIVPfSIe6DiWQqay115PEMoDXHx36ilduWjnghA5fhI6eXi
	 +BXFi6HzeibaMngeAUKM9URp3iOq47OuW3T+xUyhmmgQQiOY/pW0lW86HOL3UZDukY
	 cvhye3vrxeAEo+72wXVhshihLScQp1gM/pk8/+L3gYNmNdrlkqTGgtOIteQeGu5Vid
	 XuPZ/mu03KFraecUGPUKYUebhPMVrS33FYHheGnDFSIoz+9brM0qj5/z/8zYwreuiI
	 W+QmVXXKgBJOA==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4445c606626so282341b6e.3
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 09:01:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBQwiCSGOHnUVLbvItH6nzeXYAFpyk204Mh2aj7NzFqjqfG1WKKUUIVBg2WAeM6Sh0be0bUI/N34q5@vger.kernel.org
X-Gm-Message-State: AOJu0YzKqP4F8VxZm0LWM65Pas72HmzhaRlN9VBYadli4Gu4PWbWD1Dy
	vLJ6oHbUijM12oLYEuH2iwCRFJsJtYo++8qHgXsM6LPJ85SF6bN1rVRPJE1B8YbUh9LyYvt30th
	gj8wQTkG6UcFqYN3ZY7tAPtOVj97qeSU=
X-Google-Smtp-Source: AGHT+IHiGnwIpk7R96EUMLR2U+zETEbhiRbXkeUMvwgxxxFx0kRAAb7OL3pmxzxwhe6y2KQDpyKO8wZwSwihJbrttlU=
X-Received: by 2002:a05:6808:2229:b0:442:5fa:28ff with SMTP id
 5614622812f47-443a2efcd3cmr10789234b6e.15.1761235316075; Thu, 23 Oct 2025
 09:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022204523.10752-1-tony.luck@intel.com> <CAJZ5v0hhnAq-HJhXU8VTAWKNg0PJkYbeocCKEffYOurZn0U81Q@mail.gmail.com>
 <SJ1PR11MB60835AF413CB53076304AABCFCF0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60835AF413CB53076304AABCFCF0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 18:01:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0io8xoh2zgdo7A6sMRA9XU=s8_EF0PcUpgkH8xmui3YAw@mail.gmail.com>
X-Gm-Features: AS18NWD8JuCE3XwDXOCuivlqkn_kHwCOCiP4HApOB4ugkIQ716nGSYmIF5zXxdI
Message-ID: <CAJZ5v0io8xoh2zgdo7A6sMRA9XU=s8_EF0PcUpgkH8xmui3YAw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: MRRM: Check revision of MRRM table
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:56=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> >> Before trying to parse the MRRM table, check that the table revision
> >> is the one that is expected.
> >
> > OK, so should there be a Fixes: tag?  Or is it just a tidy-up of the co=
de?
>
> I'd be surprised if this table changed. But the h/w team that proposed th=
e
> MRRM table nagged me to check the revision "just in case". Which seems
> like good practice.
>
> Might as well add a Fixes to get this back ported in case someone locks o=
nto
> v6.16 or v6.17.
>
> Fixes: b9020bdb9f76 ("ACPI: MRRM: Minimal parse of ACPI MRRM table")
>
> Would you like me to post a V2, or can you just edit this in as you apply=
?

No worries, I can edit it.

