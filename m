Return-Path: <linux-acpi+bounces-2589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B3381C22A
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Dec 2023 01:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF799B23C12
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Dec 2023 23:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222D87949D;
	Thu, 21 Dec 2023 23:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VkNDNnEa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76A78E92
	for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2023 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e734d6cbe4so12959127b3.3
        for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2023 15:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703203193; x=1703807993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GoyFDQmGnb660Pi6Gq/ALTiVqe1qLyDsC2KvlSw7HRs=;
        b=VkNDNnEan0OQeqq+cfm6uMoJkMnja4i4kw+bo7ryirOo3pETW8YjYR/mvLjy1HBd+V
         WBlvtGS/xgXd+UWkpdDjp4iMtiBM/YT2bkv/yUyjNQErHRhJe8tzHeHWXQrPYjLI3gRT
         w7n2qlxlUM2dOqi8g99IRBOqgVdtSVBPTY/F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703203193; x=1703807993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoyFDQmGnb660Pi6Gq/ALTiVqe1qLyDsC2KvlSw7HRs=;
        b=rIIZekgLCZ2ivpo5eBLz30VStn0MVPCV3kf3SniPqir1lM4ZhTCf666jfIphv/Udtl
         /V53zaK9i1P5JRqryJM762qmGxIQbKeehhNDFCUkdCZcKHjzQD9NeamVYdw8c+oByS6V
         k/xPXuz7aynjj63GZvWfMHmraArFXBJ4Vst6DYAH0/FTk+b/Uh06QUtOz9okR1mAZcOY
         22En4mS2g36WewMp1NLtR74+8MZnf5awcTkR7d+oP/60yMR+MguzDTxSYmSmh8E/5B2T
         ZB7CThd8wBgzoqsIzospyi1jz5smwMsi/GEkReEg6m0cjWhItE+hqF1tjERg6/4HDkbQ
         S40w==
X-Gm-Message-State: AOJu0YzDRxnn9yFmY9dManKw2aZPDQ0UFHyazZoATbHFkyHrrGyXDJrm
	bAOa4grX2+C/UNYveyLo2GKAxZ1/D/wqIAw6Ijf3+Q649yfn
X-Google-Smtp-Source: AGHT+IGZlm6IlAcpDV1G32nrwa9YDyKRwIHutZS5zfJEIfXED6DzpnHlyipw3nrMS/3fI32Qtww67sHWh1Z/b7K0//I=
X-Received: by 2002:a0d:ff47:0:b0:5e0:765f:1e2b with SMTP id
 p68-20020a0dff47000000b005e0765f1e2bmr645819ywf.78.1703203192838; Thu, 21 Dec
 2023 15:59:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
 <ZYRD9Y3Y_jd1NBs8@smile.fi.intel.com> <CANg-bXDLC_+mxFU+dHyCx1K=HKTwwGw+r__6_++Co2-viTbsgQ@mail.gmail.com>
 <CAHQZ30BOA7zuRrN-kK5Qw+NYSVydfhJ0gDPr9q-U+7VKXHzG8g@mail.gmail.com>
In-Reply-To: <CAHQZ30BOA7zuRrN-kK5Qw+NYSVydfhJ0gDPr9q-U+7VKXHzG8g@mail.gmail.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Thu, 21 Dec 2023 16:59:42 -0700
Message-ID: <CANg-bXAsaKJxQ8xON59BAH1_SdVqvCQfDTco-osehjLW2T0Vmg@mail.gmail.com>
Subject: Re: [PATCH v2 20/22] device property: Modify fwnode irq_get() to use resource
To: Raul Rangel <rrangel@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Daniel Scally <djrscally@gmail.com>, 
	Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>> > > -int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
>> > > +int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
>> > > +                         unsigned int index, struct resource *r)
>> >
>> > It's perfectly fine to replace ) by , on the previous line, no need
>> > to make it shorter.
>>
>> That puts the line at 115 chars? checkpatch.pl allows a maximum line
>> length of 100. I can bump the 'index' argument up a line and keep it
>> to a length of 95?
>
>
> clang-format should do the right thing.

It formats the line as-is in the patch: with 'unsigned int index' on
the next line.

