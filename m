Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2386E100A1A
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 18:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfKRRT3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 12:19:29 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:19211
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbfKRRT3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Nov 2019 12:19:29 -0500
X-IronPort-AV: E=Sophos;i="5.68,320,1569276000"; 
   d="scan'208";a="327147313"
Received: from unknown (HELO [172.20.24.15]) ([204.98.150.10])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA; 18 Nov 2019 18:18:38 +0100
Subject: Re: [PATCH V5 1/4] ACPI: Support Generic Initiator only domains
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Tao Xu <tao3.xu@intel.com>, Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, Keith Busch <keith.busch@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linuxarm <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com>
 <20191004114330.104746-2-Jonathan.Cameron@huawei.com>
 <CAPcyv4jZG-5s6NsS-_-oNG45y0Qb1mVD_s8cCGqLYtzvHqEo+Q@mail.gmail.com>
 <20191113094742.00000dc4@huawei.com>
 <77b6a6e8-9d44-1e1c-3bf0-a8d04833598d@intel.com>
 <20191113174845.000009d3@huawei.com>
 <CAPcyv4g5xUBp871+T26+se8WH9154g7V81qsToYAbXAALMuhKQ@mail.gmail.com>
 <20191114112504.00005b61@huawei.com>
 <CAPcyv4jrXvPOvoBCW8H42_og1wJ_t9_=5N4C7-OugYyNzdqBLA@mail.gmail.com>
From:   Brice Goglin <brice.goglin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=brice.goglin@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFNg91oBEADMfOyfz9iilNPe1Yy3pheXLf5O/Vpr+gFJoXcjA80bMeSWBf4on8Mt5Fg/
 jpVuNBhii0Zyq4Lip1I2ve+WQjfL3ixYQqvNRLgfw/FL0gNHSOe9dVFo0ol0lT+vu3AXOVmh
 AM4IrsOp2Tmt+w89Oyvu+xwHW54CJX3kXp4c7COz79A6OhbMEPQUreerTavSvYpH5pLY55WX
 qOSdjmlXD45yobQbMg9rFBy1BECrj4DJSpym/zJMFVnyC5yAq2RdPFRyvYfS0c491adD/iw9
 eFZY1XWj+WqLSW8zEejdl78npWOucfin7eAKvov5Bqa1MLGS/2ojVMHXJN0qpStpKcueV5Px
 igX8i4O4pPT10xCXZ7R6KIGUe1FE0N7MLErLvBF6AjMyiFHix9rBG0pWADgCQUUFjc8YBKng
 nwIKl39uSpk5W5rXbZ9nF3Gp/uigTBNVvaLO4PIDw9J3svHQwCB31COsUWS1QhoLMIQPdUkk
 GarScanm8i37Ut9G+nB4nLeDRYpPIVBFXFD/DROIEfLqOXNbGwOjDd5RWuzA0TNzJSeOkH/0
 qYr3gywjiE81zALO3UeDj8TaPAv3Dmu7SoI86Bl7qm6UOnSL7KQxZWuMTlU3BF3d+0Ly0qxv
 k1XRPrL58IyoHIgAVom0uUnLkRKHczdhGDpNzsQDJaO71EPp8QARAQABuQINBFNg91oBEADp
 3vwjw8tQBnNfYJNJMs6AXC8PXB5uApT1pJ0fioaXvifPNL6gzsGtAF53aLeqB7UXuByHr8Bm
 sz7BvwA06XfXXdyLQP+8Oz3ZnUpw5inDIzLpRbUuAjI+IjUtguIKAkU1rZNdCXMOqEwCaomR
 itwaiX9H7yiDTKCUaqx8yAuAQWactWDdyFii2FA7IwVlD/GBqMWVweZsMfeWgPumKB3jyElm
 1RpkzULrtKbu7MToMH2fmWqBtTkRptABkY7VEd8qENKJBZKJGiskFk6ylp8VzZdwbAtEDDTG
 K00Vg4PZGiIGbQo8mBqbc63DY+MdyUEksTTu2gTcqZMm/unQUJA8xB4JrTAyljo/peIt6lsQ
 a4+/eVolfKL1t1C3DY8f4wMoqnZORagnWA2oHsLsYKvcnqzA0QtYIIb1S1YatV+MNMFf3HuN
 7xr/jWlfdt59quXiOHU3qxIzXJo/OfC3mwNW4zQWJkG233UOf6YErmrSaTIBTIWF8CxGY9iX
 PaJGNYSUa6R/VJS09EWeZgRz9Gk3h5AyDrdo5RFN9HNwOj41o0cjeLDF69092Lg5p5isuOqs
 rlPi5imHKcDtrXS7LacUI6H0c8onWoH9LuW99WznEtFgPJg++TAvf9M2x57Gzl+/nYTB5/Kp
 l1qdPPC91zUipiKbnF5f8bQpol0WC+ovmQARAQABiQIfBBgBAgAJBQJTYPdaAhsMAAoJEESR
 kPMjWr074+0P/iEcN27dx3oBTzoeGEBhZUVQRZ7w4A61H/vW8oO8IPkZv9kFr5pCfIonmHEb
 Blg6yfjeHXwF5SF2ywWRKkRsFHpaFWywxqk9HWXu8cGR1pFsrwC3EdossuVbEFNmhjHvcAo1
 1nJ7JFzPTEnlPjE6OY9tEDwl+kp1WvyXqNk9bosaX8ivikhmhB477BA3Kv8uUE7UL6p7CBdq
 umaOFISi1we5PYE4P/6YcyhQ9Z2wH6ad2PpwAFNBwxSu+xCrVmaDskAwknf6UVPN3bt67sFA
 aVgotepx6SPhBuH4OSOxVHMDDLMu7W7pJjnSKzMcAyXmdjON05SzSaILwfceByvHAnvcFh2p
 XK9U4E/SyWZDJEcGRRt79akzZxls52stJK/2Tsr0vKtZVAwogiaKuSp+m6BRQcVVhTo/Kq3E
 0tSnsTHFeIO6QFHKJCJv4FRE3Dmtz15lueihUBowsq9Hk+u3UiLoSmrMAZ6KgA4SQxB2p8/M
 53kNJl92HHc9nc//aCQDi1R71NyhtSx+6PyivoBkuaKYs+S4pHmtsFE+5+pkUNROtm4ExLen
 4N4OL6Kq85mWGf2f6hd+OWtn8we1mADjDtdnDHuv+3E3cacFJPP/wFV94ZhqvW4QcyBWcRNF
 A5roa7vcnu/MsCcBoheR0UdYsOnJoEpSZswvC/BGqJTkA2sf
Message-ID: <d0106281-f65c-369f-ef0f-11afc5f60048@gmail.com>
Date:   Mon, 18 Nov 2019 18:18:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jrXvPOvoBCW8H42_og1wJ_t9_=5N4C7-OugYyNzdqBLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Le 16/11/2019 à 21:45, Dan Williams a écrit :
>
>> My feeling is that any existing users of access0 are definitely not going
>> to be expecting generic initiators, so we might want to do this the other
>> way around. access0 is only CPUs and memory, access1 is including
>> generic initiators.  If there are no GIs don't expose access1 at all?
> There are no consumers of the information that I know of, so I do not
> see the risk of regression.


hwloc already reads access0/initiators/ node symlinks (mostly useful for
finding which CPUs are local to kmem dax devices). If I understand
correctly the changes you propose, we would get an empty list of CPUs in
the access0/initiators/ nodes? If it only occurs on platforms with GI
(when are those coming to market?), I'd say it's not a big deal for us,
we'll manage to have users upgrade their hwloc.

Brice


