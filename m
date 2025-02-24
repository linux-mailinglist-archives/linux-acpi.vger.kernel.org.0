Return-Path: <linux-acpi+bounces-11433-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9747A42DD7
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 21:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A25D3B24D3
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D541242907;
	Mon, 24 Feb 2025 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="shgORYef"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E96322E017;
	Mon, 24 Feb 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429083; cv=none; b=jSkwppo5nAPoEYyYw0/RlM1TsRfItGNGIILKrJVaQ3fr+QAloDdwijHQC72VZI/jsYQ0fKsnxP+c/AWdh3rvP+Glqs0FS77zzkDv3NYeo1REvvJlYpEE5nk1esmxOMUQ+mREH6usssYP/T+txQ7Ngozlkgkn8pWZOqtkQsLlPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429083; c=relaxed/simple;
	bh=uFkyYwefVXbs9RH0wKx78GXwRnOm1BJFk0nESRfQUDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpYp1g2pGjyz5AKZDpCXzKLTdM4yGRFfRAAGXvWGyRsZttwYDxjve8uAxDLnF2Flj42OrMCdd5BcIQAN+wjZi9YXLhb+DQLcUAZ86sjwdaXn1YZNZEs357NHnTlJ3oF8o509ptSzhfF1AastvqnO+lMgx/YzYNuV0U4PYQeXA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=shgORYef; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id A908C2E094D4;
	Mon, 24 Feb 2025 22:31:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740429078;
	bh=uFkyYwefVXbs9RH0wKx78GXwRnOm1BJFk0nESRfQUDA=;
	h=Received:From:Subject:To;
	b=shgORYef6/aDAInYTnGq1PBKjJPnLCz5LW7oJo+Pg00YhChupHUm4xdLq6F37P4P+
	 jXxeIEyPadtR1GnHokpWNvNK5i6ozK/27NnH58Ry6rijgHZvqcnkfXE8Yp/oEZoepo
	 saKoeb25duakyOWQPQo13cnFRhZTyXb2CrhESA24=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-30613802a59so50084721fa.0;
        Mon, 24 Feb 2025 12:31:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU6kYnmJa7YiSODpt8Hrq9ASMApC7XQA8iSbjTcPpVhph0+VXRp3DT74pBsHqlkD+IQBKjG1BfaVdc3@vger.kernel.org,
 AJvYcCXHM/ja0lHSKWHF1IJ+aYQoKTmSkLaR65dUZaUGC4EyhdSRXa5LyfjMW0p/a8idBp6F/FhkvoO4qqfO+1Dr@vger.kernel.org,
 AJvYcCXqdhdmjLGY9VK601barCKbrOpZ0gseJTLm2jQVTZppG4F7iP5mw6bm22m81bJeBz/6ykd77SCvBl4tJPbNy6AR0P15ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2oVuuuDaw6jcjznUxHr9QG+l8p6PZfSnVPmHIowJSFWacxXzu
	vfBQ5gmzkbQVrsGGamYfggP97xInNpw1UxpzqmIRcDQOacbhTBGprQ1X+fgQE0+q0J4aMpj3GPv
	aA9xTcu/BUvt/4AwQriZR8TChndU=
X-Google-Smtp-Source: 
 AGHT+IGEf07IcnW1XSNZWKmWbz8wCO/z/5Dg+FPZEtSqWkDrYKNmw56WDgNwiLXeLj0iNi7Iw8gR9p+7k9JIpS5JClk=
X-Received: by 2002:a2e:96c3:0:b0:308:f92e:625d with SMTP id
 38308e7fff4ca-30a598937d4mr49992271fa.15.1740429076979; Mon, 24 Feb 2025
 12:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224195059.10185-1-lkml@antheas.dev>
 <681f9ec4-7b43-4e14-b098-dddc3a9ae29b@amd.com>
In-Reply-To: <681f9ec4-7b43-4e14-b098-dddc3a9ae29b@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 24 Feb 2025 21:31:05 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGaPOSk6oEsLRSc1Kj+UaP2wUZh_pYujY7RwoPDiAJcUg@mail.gmail.com>
X-Gm-Features: AWEUYZnxbTOa-qfKwekcuP6s_vor_IhTHUxbI59TkfIAu16aMDRIw2-jYxaF7gg
Message-ID: 
 <CAGwozwGaPOSk6oEsLRSc1Kj+UaP2wUZh_pYujY7RwoPDiAJcUg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: mpearson-lenovo@squebb.ca, ilpo.jarvinen@linux.intel.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, rafael@kernel.org, hdegoede@redhat.com,
	me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174042907816.20133.2563098575207279468@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

That is a very good question, but a summary search along the drivers
reveals that some laptops have both low-power and quiet, so it is not
that clear cut.

If you ask me, three is all you need + custom

Antheas

