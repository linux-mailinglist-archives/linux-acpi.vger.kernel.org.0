Return-Path: <linux-acpi+bounces-12850-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD84CA80BA2
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 15:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F5B1BC06D8
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120038634C;
	Tue,  8 Apr 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNjFiC5X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D680C02;
	Tue,  8 Apr 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117255; cv=none; b=sULw1RZlC0dKKjE2BWyanvMuy5q5qKoeAtGJs1WrJO+cbHy4uC6AKH9WvPWqzw/PmnQ6O2GuwL1IryQgAvWlZdPQ/vAH5CG6pPUvxvr4Q3E1SooY+LfzGouDQ4M8PJO2pyhQRabaPh7pauWT+KdpZ7qlOdxFnYUIfpQH7B78WHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117255; c=relaxed/simple;
	bh=Aknki6s1igQM/Eo/fOwSNCs6u83k6YRBUPCvCg2YfMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScYfCzxktCH9cX9dnmdl8LNT4V8c9kc2rc94YotL21Vf3NezDwcE3fKnCKYu87JjNSXK1kXac/eaNknqMOYnXcnzCB+YWu/Ui8cYBOBFyky5Dmx9zi+i34xh2ZXJxWPFnQafrIk4TFTeukY7kDdIaWfagi6eTYa/3dU7bBUfGEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNjFiC5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DE1C4CEE5;
	Tue,  8 Apr 2025 13:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744117254;
	bh=Aknki6s1igQM/Eo/fOwSNCs6u83k6YRBUPCvCg2YfMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PNjFiC5XlfUBaGxhyYMMrFC3DJ2Sfx7Jn1eXcErlTN0IvIfaAzoo9Ez41UVBVGBiC
	 UoC8Ih7R9g+OuEqg5+55bSLpP9nOPVDYdNyzshqek7hT43LgSw3EZpUL6EkFODC+/j
	 lvdZK60feF1j9rLctZo0KM1bi52voMWvaRkUaUjTNuexD1ZaCy8YYPMZzxQ3tLmN0z
	 ToGh0uDsK3AQRnfd/RzKqG7KZnIqO8ycYJ5yDEkCx+g32MUBjrFd7chUm9HwnK5pbF
	 5JtcZkxyE885FiGCKRyjIcvZ8prSyU2mRsgL+qzspQMOG1wUXO5TC9D8k69bAzZGdC
	 5FeBgauaWj4Bw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac73723b2d5so1145691466b.3;
        Tue, 08 Apr 2025 06:00:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxEsiwWZcqr/+Cvu7kJMJxTY3EVcM8BzybW/F5f7079FcbdaYBdOgJtHstDn0Py5tFWw2zdrD6rvqNuQ==@vger.kernel.org, AJvYcCWbeoEYmaNdokHiTYBkYeuhI5/sajQJuo+w367RCbu/cfXwvjiMGlEIYkUzytn873RRom5OkdkPYGO0@vger.kernel.org, AJvYcCXhPDtr8SHA6rgKUpsVWNjapH2uz53rMprO+F2U1kR2y9BGhORob6Pooo7Bu4FhNN5PWyhNchW0R+3OFFhg@vger.kernel.org
X-Gm-Message-State: AOJu0YxnER5m/RIrZTaATu3Nw+uyBs/1hLFKxUAgW/vrg0HRJTWBwq3u
	/paHPKcA6C7OzohM0y4/WWgKCdvFofr65EDpwBfWbpZOpRvGrv5qVxqTg1oysqH2jvb+S3XK9do
	+Xuov04iawn2M/9rhUnk89Z4sFA==
X-Google-Smtp-Source: AGHT+IEIFbZ/VySFNhPS9VbSSf72FCcLurPLqXyg7psGtmDjYbg+I6LwO1ocXD7pga0Z9QTXsdpGpDneAuLkUMDfe/I=
X-Received: by 2002:a17:907:969f:b0:ac7:c5bb:3b21 with SMTP id
 a640c23a62f3a-ac7e71b1f33mr1206431966b.13.1744117252440; Tue, 08 Apr 2025
 06:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407223714.2287202-1-sean.anderson@linux.dev> <20250407223714.2287202-3-sean.anderson@linux.dev>
In-Reply-To: <20250407223714.2287202-3-sean.anderson@linux.dev>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Apr 2025 08:00:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLQvyBvOXJJhRcnVAVx81MUf9YwtyZ5VC-whwY=uoeDXw@mail.gmail.com>
X-Gm-Features: ATxdqUH9SYHqPHdjPN-N3uuh5HF5pHyCtZZKigzGpkEh3qURSGekLdlIrc9NheI
Message-ID: <CAL_JsqLQvyBvOXJJhRcnVAVx81MUf9YwtyZ5VC-whwY=uoeDXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] device property: Add fwnode_property_get_reference_optional_args
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 5:37=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:
>
> Add a fwnode variant of of_parse_phandle_with_optional_args to allow
> nargs_prop to be absent from the referenced node. This improves
> compatibility for references where the devicetree might not always have
> nargs_prop.

Can't we just make fwnode_property_get_reference_args() handle this
case? Or why is it not just a 1 line wrapper function?

