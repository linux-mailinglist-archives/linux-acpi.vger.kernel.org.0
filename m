Return-Path: <linux-acpi+bounces-7646-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E095631C
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 07:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A389B1F224B0
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 05:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4768F14A09C;
	Mon, 19 Aug 2024 05:23:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F23EA69;
	Mon, 19 Aug 2024 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045027; cv=none; b=I9OuatGI3vGxGAQxA2MJmg7l5PtPtd0IMlFH9dDFia6rNMy/yS/sqd1JZVu923trYeFI4YPGOi3sJ2azzB+0ciycs6g6ZxUBGgKxMtFS+Oxv4szi3mrOz4vZwomVVazSFFq/4+vIzGJ9fMJ70et0V2kbiEpharJbktwKvaPv7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045027; c=relaxed/simple;
	bh=X3EgMsIbon1gHKAxnq591Y3MaAWr5c+4mgi81laTTTo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rt1+3Am4m1Qu/lUcw4m6Y6eGuaSLylcRPqnoyRECi4fxRP1NBtwhKLsQFm2oh73f80dw/zP5xl67Ow1C2LIUX8EPf+5PoscRfFEZm87PU3dUGp/Q66hl9cbmxdeT7nXN3O1HOp9WPfaqk8WFCGuM/XfZYo21fgUWdv0wcCsABrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so30924425e9.2;
        Sun, 18 Aug 2024 22:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724045024; x=1724649824;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRPnZgfuD04mlqn1AsHHKOM++TRQ9dP251PdCGyiwmk=;
        b=m7UlB4zCUUYP722gxN9+pNWTG6Ajfot/FbP2n+NcNQb9Hir+LA50ImGmqgJ4iPHDed
         ZH208pWsjWvQvBLRPd8/1mY6DxZm43GspgV2VZTFP3LTbOnxqDKPSElN9v7cJWcerrUa
         q4O9dELTzNeeGVUdCTw4SrW+xigokVhwSQ3kWLtwOIJjjsJnyUDAYnagg9ymUZKhOvqA
         aziGa2dq32mjpGCk5/g0P+i3RGGKQtOGDC54uv33LwNkDfR73LYhpNuGqzsvMvez5Je4
         KTjECMA26q63Urv6DtZNExoWgwgI/QFgDAI+JJPVtDALyfZ/JUGJzsbiFMAOO3fQa/V4
         9Obw==
X-Forwarded-Encrypted: i=1; AJvYcCWNQ4iim2tM3lZUoEu85dKx6ePMxsdMlBrFx3eMoLWkCruWq+jK0mB0QaABH6TBi8MCbafoP+T4ZluJcGr8Mry3O8+aGGNXRlJlYCTXkKjGdVQp/5sm4p02znTQR+3FFU+RskhhvfOsYg==
X-Gm-Message-State: AOJu0YwEr4jLt8+sFIr+oglsrA4lrgYfwVk0wP9WqVkW7n4le62DVKZm
	6GRss395Wnw0XETKGGRglJODfcUave9OSsNM0hWm/yGDIZuSRjDQ
X-Google-Smtp-Source: AGHT+IHKzVPlN+RRAyCEZScNVcdul0vfaAZE0h4JYP0WeGlRZ4xobxUDZoF2oj/4yb3KyKR8uZjxNA==
X-Received: by 2002:a05:600c:4692:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-429ed7856b4mr71755305e9.5.1724045023749;
        Sun, 18 Aug 2024 22:23:43 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aa229sm9438557f8f.88.2024.08.18.22.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 22:23:43 -0700 (PDT)
Message-ID: <782b7159-076a-4064-8333-69c454972b29@kernel.org>
Date: Mon, 19 Aug 2024 07:23:42 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI IRQ storm with 6.10
From: Jiri Slaby <jirislaby@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 "Rafael J. Wysocki" <rafael@kernel.org>, Petr Valenta <petr@jevklidu.cz>
References: <60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org>
 <bd149809-f670-4b5d-a18a-f1f63624265f@kernel.org>
 <CAJZ5v0jrgC+cvjDfw+vQ1jyVz1oj28uTf9k+-Kk2EAPJj3VmdQ@mail.gmail.com>
 <6eac5c37-a5a8-4ccf-aef6-62a4a0bfcea0@jevklidu.cz>
 <95ef6fd9-6d86-40e2-9814-d1f671b2262d@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <95ef6fd9-6d86-40e2-9814-d1f671b2262d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19. 08. 24, 6:50, Jiri Slaby wrote:
> CC e1000e guys + Jesse (due to 75a3f93b5383) + Bjorn (due to b2c289415b2b)

Bjorn,

I am confused by these changes:
==========================================
@@ -291,16 +288,13 @@ static int e1000_set_link_ksettings(struct 
net_device *net
dev,
          * duplex is forced.
          */
         if (cmd->base.eth_tp_mdix_ctrl) {
-               if (hw->phy.media_type != e1000_media_type_copper) {
-                       ret_val = -EOPNOTSUPP;
-                       goto out;
-               }
+               if (hw->phy.media_type != e1000_media_type_copper)
+                       return -EOPNOTSUPP;

                 if ((cmd->base.eth_tp_mdix_ctrl != ETH_TP_MDI_AUTO) &&
                     (cmd->base.autoneg != AUTONEG_ENABLE)) {
                         e_err("forcing MDI/MDI-X state is not supported 
when lin
k speed and/or duplex are forced\n");
-                       ret_val = -EINVAL;
-                       goto out;
+                       return -EINVAL;
                 }
         }

@@ -347,7 +341,6 @@ static int e1000_set_link_ksettings(struct 
net_device *netde
v,
         }

  out:
-       pm_runtime_put_sync(netdev->dev.parent);
         clear_bit(__E1000_RESETTING, &adapter->state);
         return ret_val;
  }
==========================================

So no more clear_bit(__E1000_RESETTING in the above fail paths. Is that 
intentional?

thanks,
-- 
js
suse labs


