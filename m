Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19DBE1245D7
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2019 12:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfLRLei (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Dec 2019 06:34:38 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:44355 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfLRLei (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Dec 2019 06:34:38 -0500
X-IronPort-AV: E=Sophos;i="5.69,329,1571695200"; 
   d="scan'208";a="420838954"
Received: from nat-inria-bordeaux-52-gw-01-bso.bordeaux.inria.fr (HELO [10.204.4.154]) ([194.199.1.52])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA; 18 Dec 2019 12:34:34 +0100
Subject: Re: [PATCH V6 7/7] docs: mm: numaperf.rst Add brief description for
 access class 1.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     Keith Busch <keith.busch@intel.com>, jglisse@redhat.com,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linuxarm@huawei.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tao Xu <tao3.xu@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20191216153809.105463-1-Jonathan.Cameron@huawei.com>
 <20191216153809.105463-8-Jonathan.Cameron@huawei.com>
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
Message-ID: <4cf4e790-cacb-b250-bf28-5ba540eb0dc7@gmail.com>
Date:   Wed, 18 Dec 2019 12:34:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191216153809.105463-8-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Le 16/12/2019 à 16:38, Jonathan Cameron a écrit :
> Try to make minimal changes to the document which already describes
> access class 0 in a generic fashion (including IO initiatiors that
> are not CPUs).
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/admin-guide/mm/numaperf.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
> index a80c3c37226e..327c0d72692d 100644
> --- a/Documentation/admin-guide/mm/numaperf.rst
> +++ b/Documentation/admin-guide/mm/numaperf.rst
> @@ -56,6 +56,11 @@ nodes' access characteristics share the same performance relative to other
>  linked initiator nodes. Each target within an initiator's access class,
>  though, do not necessarily perform the same as each other.
>  
> +The access class "1" is used to allow differentiation between initiators
> +that are CPUs and hence suitable for generic task scheduling, and
> +IO initiators such as GPUs and CPUs.  Unlike access class 0, only
> +nodes containing CPUs are considered.
> +
>  ================
>  NUMA Performance
>  ================
> @@ -88,6 +93,9 @@ The latency attributes are provided in nanoseconds.
>  The values reported here correspond to the rated latency and bandwidth
>  for the platform.
>  
> +Access class 0, takes the same form, but only includes values for CPU to
> +memory activity.


Shouldn't this be "class 1" here?

Both hunks look contradictory to me.

Brice


