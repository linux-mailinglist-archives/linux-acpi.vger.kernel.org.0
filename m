Return-Path: <linux-acpi+bounces-12463-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE6A72085
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67EB17A403
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E6025EFAC;
	Wed, 26 Mar 2025 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipevxhGM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070249659;
	Wed, 26 Mar 2025 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023430; cv=none; b=q1xlMx8/NPMRMG5KUvRIaAKi0T5LKlmx44VXlHaxXcTNzK6my/Lshf7KPKaH1PQKDAuTjIi/ohgOTB799fMHGIBF91MUyTZABYXfruh9AtHksgGc/aQ5+liYFT0GIFEc/DNyeUaZ0Yd2kjzw309fWrVPNkvAuCpT/wR45mFwMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023430; c=relaxed/simple;
	bh=iRDZJi2k5yP2Vo5JX6MJ6DeS8rM0uYFO+Y9AZyRctyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffY5CwiggQij7EkRbC/fpDU8HC0XlRxQ2b02iO98rpyqWuT3IDowPN1EFIQTcXSM6JKHRcUXACPA8pUz0ihvFlAXhTAp1Rz9BN/Jj9gZCv23QWIGx+s2x3euxHEHdTpftJX4N76cttsTFDhHAeMr2nilME4rMtlH0C6X4EMrOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipevxhGM; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3feb0db95e6so141379b6e.1;
        Wed, 26 Mar 2025 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743023428; x=1743628228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmXIx6lw3bResXaqVN0/2AUl10eW55ftDrxkKYdDctE=;
        b=ipevxhGMGu+5172Q9JibPP07eiD0NjL60ORUcf/hEYdJ0bokVuGNqbNd+hVmYkjanU
         bz64SyDI8dXY15rFqQxC4Vr0hxikdguFOS/5exQ8cdA9Qxk4Y2fYm9yUf5KunjwdYFBU
         76h8syFGz/h6Is+ANumN6XSKoO8vzYWwzxNFKcLnUfqIeB8K3YAi27QdiUhF+Ql9tQ8J
         NcdBteb7tnEvg56TvwSnVviz9SHL6+vmcdESUjb1Zv56WZk80W9Gaow9A8q6xycK4/q2
         HR/AHcXSHdNXSQTlKQDWgVuAQifR9MSI4N6gbCeRFk44zWKDERECPOHo22v+mLHlNMvJ
         7DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023428; x=1743628228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmXIx6lw3bResXaqVN0/2AUl10eW55ftDrxkKYdDctE=;
        b=JVQPABWxYVuIaVDgaGxATHVWPx1/jI3TUP2/ps1xBKKfIO23v831IGJmR2KbfZw3TC
         Hy8DzpfLjBB0L3ExrjKSXEQrUhJyfmgjoJ7sStdVYg9NLmM7wqNs2Bs5l1Bbt5+x0QfE
         SS6+Pdy4sXUCrdshYinAHNNUuMWhpIiYcK5cgnDNNlUFfUQdtSL0iI6r9CnKmzkKpzav
         lLo9iT9CBk7U+A8zBMmBxbMfBvMk31pCMUQu1iVRL4FedGbyTw4CSicbUHovnODkLCWc
         LGaD+NOCsPMNyOBjklzCF26xvKBadEEPwToDN9PQs3pxuDrT1sSlRSsdzwENGVpCw/Lt
         zTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlQpaeYa1T95/mEE0IShbksCtKJw4mVOv4Xf1yVyCzmhzBVFF99nKbv322wEcJbCy7NcBBOdxZHQibLUebkAs=@vger.kernel.org, AJvYcCX1DoGR40yWbP66fG3PkwaPStruE2Dgq9LJLb1MNo/10QLMKZzEHkcbLoZEo2y20fIhti3yvRJpaknqFww9@vger.kernel.org, AJvYcCXK1TC3MdRnDflM6qjZH8vqLCK5VOMi9xt0nqa9lD0AOnUTpEwx5dpqxeMtDGmYZu04IxQWSkmgRpXz@vger.kernel.org, AJvYcCXVqPPEwoA0SnufXi9pW7oYU09o11zW8ndSCJ/VmCROxi9iOs7SZUsXUe3y4ydL7ctBljAhgdo14ZNn9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYeDmXUSF2Un2HCbN0+CXi4B7dmn/G61YshXSV422UR+RU2Eh3
	/qUD9cC5oDdbJgLZt4oZcvKBhvPfLHPxYJwqozaXKXB4eTkC84vJ
X-Gm-Gg: ASbGncu6RJ/lAQU0xhXomc147l8z/akImOkk9KksJrvbzLw834J1IiAQ7C0zPG7s4Zm
	vuOk2VGQVQYqcRs0gwl9Fm20YJvlpTmufpJK4xOHZZAX2b3LONtOwDhvtb5oqJHBZad1C/6+cxl
	TkoiG8F4YHHU9l2ztEqeAuLpDitph3Fb62C5sq2Ch4hTSZVzpP9OPLx08JirJmmucUqU1o99zhj
	KTjRpbRbCo6N33oOF7MmamiwuAWSh4+RsKGzjnO+ng/xJZL13aRIO9MA/bSaKKCLIg/snigMqbB
	qAnYW5RFg4HBFoJoYlbxh40HUJer0uNzT8++J2FbIVb62AM6H9eIhcZeZ0WDC1lkfyyBnJ6NYGW
	XBFFnkfgC7MwdorsEezqMwonMylg=
X-Google-Smtp-Source: AGHT+IGr7K3MeJvrN0pjniNa9v3V5nH4q3LMTZ9m/DyIjiFtUWjHaZNIloO5JjzQVN0t73CR/ha4rA==
X-Received: by 2002:a05:6808:6f93:b0:3fe:b0ad:f935 with SMTP id 5614622812f47-3fefa4eaa14mr713457b6e.4.1743023427977;
        Wed, 26 Mar 2025 14:10:27 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3febf6e94e7sm2538721b6e.17.2025.03.26.14.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:10:27 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: remo@buenzli.dev
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	andriy.shevchenko@linux.intel.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	devicetree@vger.kernel.org,
	dirk.behme@de.bosch.com,
	djrscally@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	robh@kernel.org,
	rust-for-linux@vger.kernel.org,
	sakari.ailus@linux.intel.com,
	saravanak@google.com,
	tmgross@umich.edu,
	andrewjballance@gmail.com
Subject: Re: [PATCH 09/10] rust: property: Add PropertyGuard
Date: Wed, 26 Mar 2025 16:10:06 -0500
Message-ID: <20250326211006.696727-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326171411.590681-10-remo@buenzli.dev>
References: <20250326171411.590681-10-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Mar 26, 2025 at 12:13 PM Remo Senekowitsch Wrote: 
> +/// A helper for reading device properties.
> +///
> +/// Use [Self::required] if a missing property is considered a bug and
> +/// [Self::optional] otherwise.
> +///
> +/// For convenience, [Self::or] and [Self::or_default] are provided.
> +pub struct PropertyGuard<'fwnode, 'name, T> {

nit: when linking items in rustdoc comments you should suround them like [`this`]

Andrew

