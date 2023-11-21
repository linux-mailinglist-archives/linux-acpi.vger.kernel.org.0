Return-Path: <linux-acpi+bounces-1674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1F7F3101
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 15:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52F0B20C1F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D64A9BD
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1gYLyN7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81426D6D
	for <linux-acpi@vger.kernel.org>; Tue, 21 Nov 2023 05:32:21 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5c9169300caso32372937b3.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Nov 2023 05:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700573540; x=1701178340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhGZv1Nv08MvRW2DJYjs+d3sOa+HumQD0w2cfdSjlYU=;
        b=o1gYLyN7nepNx9mjc188FdMxaA/2ONPzvIHKI5fpxkddLVUjPTjn65ZJGM+RNe+0rV
         AgceHBBzOy0c3EHEDVDv3Dbf+2iX5thOtT9KQZK6DHP3x4unuWL4ge+czeQcqyLq9ts3
         HGOBjdF76wVvKqR0oJYw96hcFG2CHTQwGRUcPybljtcl+UBwnij3jXSTq2YPR3kuyEnM
         drqRv7WrNNIfdAIoCIbQEq4/f5GO7ihEtZsQ4fqI0go1VsGG4XgDhFfHIHwLBg+kuifV
         DbPzikbC7Rz4oHPMjM6A9p1+u7t/ZmRziYNp2roP+I8m8lMvPbN65pvZplMKC8g74n6Z
         3b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700573540; x=1701178340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhGZv1Nv08MvRW2DJYjs+d3sOa+HumQD0w2cfdSjlYU=;
        b=bwBtIT25KJRQwOv9N86wezsfQK0cBjUn4TSdfnjwPnUfZLCal4CDrMxWjDRbnkHUIW
         kOH2Ig/oI4jDPpShOSjKl9sIpaKMKQjq+hibLIr6C8qVjVysZdVTYBDwawLX3R9gOC66
         ZjcPZ4IAfBw45j9pSsGXfma0ObcPaksPmsEOv2Hm6p9uJTV7wl3AjRU/mI+/g5Z+Lksc
         g5efV+N0+B8onyGoRDelY8WRDgMLemzycNi1a7mMQIlX30uKNSw1IMWpi+zj0pgKDC7e
         xFJbd5QWbpPu5DY4ena8q7UVU+7aG2aV15rKI3z6rTpDERRkcyHLx4JJ33dBUCRd05Vf
         4Ajg==
X-Gm-Message-State: AOJu0YxTAonaPS34Ry3oiJSuNvb6wrS0lZhKMlsvyaG6011Ul6ZLOotU
	bsoRNcu/OJQAOS1zuaNofCk7C+euq5K7iF5wbaaV86L28AlYfmj8
X-Google-Smtp-Source: AGHT+IG5fMKPSUUlBQk/9z9KQDvVshTXZ/yb2JO2VCDadLEWCNWZCTpRysGdod7EeVu9BQ2Pr8mBjhdK5xSfgbEhxcM=
X-Received: by 2002:a81:b606:0:b0:5c9:70b9:84d5 with SMTP id
 u6-20020a81b606000000b005c970b984d5mr8331718ywh.8.1700573540642; Tue, 21 Nov
 2023 05:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
 <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com> <CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com>
 <41160dbf-d8c8-4dc0-9fda-42cc97df5b77@intel.com> <CAJZ5v0jNOXKv2fHNGUDjDvvg6FGbXuahhH9dBhWiAwiPv3fH8A@mail.gmail.com>
 <736fcad7-f440-4bcd-86fb-4cc73d1b8f37@intel.com>
In-Reply-To: <736fcad7-f440-4bcd-86fb-4cc73d1b8f37@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 21 Nov 2023 14:32:08 +0100
Message-ID: <CACRpkdbz=a7yoJdBOrgJXth53d=F7+eQCu7KofUW8s1rBY=Veg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sam Edwards <cfsworks@gmail.com>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Dan Williams <dan.j.williams@intel.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 5:53=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:

> However, if I move fw_table.h in linux/acpi.h below include of asm/acpi.h=
, then we
> can build successfully w/o including acpi/acpi.h in fw_table.h.

This looks reasonable to me, can you send a formal patch so I can test?

Yours,
Linus Walleij

