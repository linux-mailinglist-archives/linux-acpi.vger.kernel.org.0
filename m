Return-Path: <linux-acpi+bounces-10422-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B1AA04938
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 19:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693871886216
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFDA1F4298;
	Tue,  7 Jan 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F31p3k3Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377FD1F4295
	for <linux-acpi@vger.kernel.org>; Tue,  7 Jan 2025 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274613; cv=none; b=acmcVP6xpcBTBfjEe4tcthJIpU+JbHEMK1roSUG5jnduwvkX1+HNEBslBiNlujOIwMAh59m1p+Tmyomi9Vn4dO/JZ6ucKE148q8OQAaQ7eAzQUMdd5AKiFPRM+csFS3O3BP87uKElZQRGj7NzdXVdFt8LUm3cr5MsiD60/5AiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274613; c=relaxed/simple;
	bh=3gLpZzr2geIMs7aEkGeMfgvBIsdzh9cc357lF4j07UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyYaFxApKCjwddZYYpWRI90cRfqgH1SpwOscTKRxMKFUi9cMN1+f8WmhwYNT7sMaQo38CCmaRMWAoCxt0f71J1JMCJgfDDr6NMS8iAl+SyFuwCxpqtHJG14cDaIQZjn0cu2vlv+tWpreeqe/2cVepLk1m+xY927yCWvh5VIBQhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F31p3k3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6688C4AF09
	for <linux-acpi@vger.kernel.org>; Tue,  7 Jan 2025 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736274611;
	bh=3gLpZzr2geIMs7aEkGeMfgvBIsdzh9cc357lF4j07UU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F31p3k3ZRoVxLa7LF2E8s0d2h426DC9gtaYZHAHcHie2uI3mySWA87E90felrZVTX
	 2lBLGfItiiwIQIoc471IZ/WNkbNytdGYz6TQK6Jph9K6T0+aU/RkGLOFcUoZ9JfHia
	 7f4zFgldJIrT3a550xusJ+VXVp0n6rhFoFKKX5LjsDuKUjJrhc953LUQMcv5DDqw/+
	 OuXlLm7SkAICHrh1mQBAWrFQRy/Zth4BmCFko9ydeOIiqFimOWXDPs6jOXZBhGWkng
	 7QOm62GwrtAh8PzlRPJnfuQOx748nv63cLpq9PJhJnfOuGpyb8FDrzWZcV9ErMLvrH
	 ieWiTKDoIhQyw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f6ab7e0bd6so3086701eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jan 2025 10:30:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCwC57KHPzhS+yJHHbz9WwE0AO8nX1qegCsF4O35a2lMEUpKY7h33m2pplB7RFVsFAw14HaDf4e676@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEZAzXRs970HyMO9MHMlS9eOWXMFzeyKnL3W9t8SHKaqe8ZKn
	2zetUCQaEWv7lxCgGdfQQjO23unXtjcck4/zD29HXN8fB/IT7pWfGuH2F2pkzIaJ+YmiGycc7Zz
	Rz6HFWRIozQOrA58pohhzLVxH9V4=
X-Google-Smtp-Source: AGHT+IH1v2aOrtiJyZCT/mSTaiVGAGa9A8QQjfbGbob3lhiqS6iAUPTZMVaY5x1igtqzIKf8xRo7JmonK9gEP3/qxcc=
X-Received: by 2002:a05:6820:16a4:b0:5f2:d98b:d95d with SMTP id
 006d021491bc7-5f62e771acdmr32310301eaf.4.1736274611106; Tue, 07 Jan 2025
 10:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228165253.42584-1-hdegoede@redhat.com> <92c1b02f-d9ba-48a1-80fb-8edd4addba8d@amd.com>
In-Reply-To: <92c1b02f-d9ba-48a1-80fb-8edd4addba8d@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Jan 2025 19:30:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hmVYdhGwgnJMNu+fDPufYrLqWhFvSRXJ0pvv1+dVC9gg@mail.gmail.com>
X-Gm-Features: AbW1kvbsShr6Iid9M5z2fISOkT-3vxcePf22GVUUNpdAR9ADYX2_zhPVXr3mus8
Message-ID: <CAJZ5v0hmVYdhGwgnJMNu+fDPufYrLqWhFvSRXJ0pvv1+dVC9gg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acpi_dev_irq_override(): Check DMI match last
To: Mario Limonciello <mario.limonciello@amd.com>, Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Werner Sembach <wse@tuxedocomputers.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 4:32=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/28/2024 10:52, Hans de Goede wrote:
> > acpi_dev_irq_override() gets called approx. 30 times during boot (15 le=
gacy
> > IRQs * 2 override_table entries). Of these 30 calls at max 1 will match
> > the non DMI checks done by acpi_dev_irq_override(). The dmi_check_syste=
m()
> > check is by far the most expensive check done by acpi_dev_irq_override(=
),
> > make this call the last check done by acpi_dev_irq_override() so that i=
t
> > will be called at max 1 time instead of 30 times.
> >
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Applied as 6.13-rc material, thanks!

