Return-Path: <linux-acpi+bounces-10148-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D33D9F394B
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 19:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF38916A505
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97245126C08;
	Mon, 16 Dec 2024 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzLBuZyp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BE207666
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375047; cv=none; b=HH3KgGEctwYon9HhkRQ/kDbhX+qgIX8DjUN4Wdk0RNk73SGM2ZnxZw7SXfiy8Zm3barMau+cLMiJWpLkJoOmyXxW0e+zN4mygAh5LWnfE2/vtCJ/K44taw31jKCmRuU7Osg72l4gjg4mpNBqV/JVp9RMfOWF3d0AMViaDFdcOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375047; c=relaxed/simple;
	bh=ZM4EbKJqyaw0HQduToe1Q8l8IpvQkXAMD9vBtM90ZGM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ksNy3R1O3EIOp/vuHWYWynBUE0qQ9IZFf3BEVr+AGJrzkXImomz0SwTBcw7aX76T7g9z4cNwCLM+02quHTV0BYL/s5oW4/JnERlAsDkribEdfYBWA7aWFggldJkTXEqVL00UXVa2OmhJt1RznmEjP+d2QbjYeHeUspm+CmpKiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzLBuZyp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so600503066b.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 10:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734375044; x=1734979844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FBzMZLxWDCW811W9rb5/HMAa6G5zYq6lrFVWFLZqyqQ=;
        b=QzLBuZypqVCSA7+rBcE36FthOpaUgz4GBL985+Z2madynL1/lvjymgwJ0hl7ETpbgx
         PS5uV9z4PF5aShOAFYQJGsEC+2XTa975oXQCUwRJ/8iVkcFD89Yw4haHsW2VsXpGMOGt
         ZldptxPx2uuHDVUpEz6bpQM+/Cn3XmuRQqUkTyS2Ny0MzCcPn1O760TNrjsJbz8NJ1YJ
         /wHwSXHCWVDqXbawVGP+mE+JOBH7IDY961/NZ2gNE1oiPJnH8mvJ0nXrLBEhGqg1rymG
         NWnV0hN1DJS3/KS5k9+ZEJjaHGuxBqF0KZ/4RBGhaDMTW9hOXfQVNH29a+hBJOotECyo
         /9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734375044; x=1734979844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBzMZLxWDCW811W9rb5/HMAa6G5zYq6lrFVWFLZqyqQ=;
        b=ear3uSeZ3SEnLA1pGAQtA3Qx6JzITfiVaySS7osHiemQ4K/nz+NWF0tnE9pmVfa6aP
         bITo3WNGFDGURMxM0xliUGBCI+gkEhTJcDlljasBDG1UT3VjfvRUHtGbwrl9DKIoKTCo
         oQk6iJkbiAcQW9TbZJFcQ2WBYoY8t7VD7g8nFTmsvwbXyLiGVQk1QAZzpCftxRn3tt2+
         fimbMW/6ptCyeui6hWExGxdakxJzeogX/FwaFXQgHI6riS89CmdLk/jYJ3d5E7ZVauT6
         4PK1zN3piR5/U87lC7zDm+PXZ7wyn0+H7LZar6zHoYTN5cg7PPH+q4PewlCG4L07V/bX
         61PQ==
X-Gm-Message-State: AOJu0YywxwBWqSPPM71dHK/0JZVhIQ2mCluF/k1seCB7zPpVncfRqL+U
	f842We1gr16glmeUbLfghQWxwiQN7xNxIBQ1Ej8esNSEwY6cDJh/r8UviEaHzIKPbpPQ8aZjAk7
	NxDuDVZBY5dyhVxWeNXkq0nQ0r4scDj6y
X-Gm-Gg: ASbGncsK33Tapki4URTJM8P0DErSXlUGLrePZkFBU5oGf+w2jDMivs+Qe7Py5ABa25d
	uW63HHL7/xIzhH+t0XdjtMVW474I+ZQESoeok2NA=
X-Google-Smtp-Source: AGHT+IHnO4RiihKu4sDuBT5ENeGwQXGNzXgh+6t5enzzL5eKm0VE+yEDDgswIOnK7gSzq/shhVqXqUe45tyioND5o94=
X-Received: by 2002:a05:6402:51c6:b0:5d2:7199:ac2 with SMTP id
 4fb4d7f45d1cf-5d63c300da1mr29398555a12.2.1734375043896; Mon, 16 Dec 2024
 10:50:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jack Bourke-Mckenna <jackbourkemckenna@gmail.com>
Date: Mon, 16 Dec 2024 18:50:38 +0000
Message-ID: <CAHGTsivNWhWMPnH-dDunoAH36GAxV97-xwaZ2Pi_YdpnpiLfnw@mail.gmail.com>
Subject: Proposal: Defaulting to s2idle on Lenovo E14
To: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael J. Wysocki and ACPI maintainers,

I wanted to ask about improving Linux support for the Lenovo ThinkPad
E14 Type 20RA. Right now, this laptop defaults to the "deep" sleep
state (S3), but it has resume issues. On the other hand, "s2idle"
works reliably, and users can enable it manually with the
mem_sleep_default=3Ds2idle kernel parameter.

Would it make sense to make a modification to the  ACP DMI table to
set "s2idle" as the default sleep mode for this laptop? It seems like
it would fix the suspend/resume problems out of the box without users
needing to tweak anything manually(this was a huge pain to debug).

Does this seem like the right way to address the issue? I=E2=80=99m happy t=
o
put together a patch and include logs showing the problem if you think
it=E2=80=99s worth pursuing. Or is it likely to be ignored because the E14 =
has
a relatively small user base?

Thanks for your time,
Jack

