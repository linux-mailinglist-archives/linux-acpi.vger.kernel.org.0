Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9C7117CDD
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2019 02:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfLJBEY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Dec 2019 20:04:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:57737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfLJBEX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Dec 2019 20:04:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 17:04:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; 
   d="scan'208";a="387431429"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.115]) ([10.239.197.115])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2019 17:04:21 -0800
Subject: Re: [PATCH] ACPI/HMAT: Fix the parsing of Cache Associativity and
 Write Policy
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191202070348.32148-1-tao3.xu@intel.com>
 <CAJZ5v0hqjR5EdrxcdkLUpxseFiizqNjtA3nYdDtZiSt85JiywQ@mail.gmail.com>
From:   Tao Xu <tao3.xu@intel.com>
Message-ID: <6dbcdaff-feae-68b9-006d-dd8aec032553@intel.com>
Date:   Tue, 10 Dec 2019 09:04:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hqjR5EdrxcdkLUpxseFiizqNjtA3nYdDtZiSt85JiywQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/9/2019 6:01 PM, Rafael J. Wysocki wrote:
> On Mon, Dec 2, 2019 at 8:03 AM Tao Xu <tao3.xu@intel.com> wrote:
>>
>> In chapter 5.2.27.5, Table 5-147: Field "Cache Attributes" of
>> ACPI 6.3 spec: 0 is "None", 1 is "Direct Mapped", 2 is "Complex Cache
>> Indexing" for Cache Associativity; 0 is "None", 1 is "Write Back",
>> 2 is "Write Through" for Write Policy.
> 
> Well, I'm not sure what the connection between the above statement,
> which is correct AFAICS, and the changes made by the patch is.
> 
> Is that the *_OTHER symbol names are confusing or something deeper?
> 

Because in include/acpi/actbl1.h:

#define ACPI_HMAT_CA_NONE                     (0)

ACPI_HMAT_CA_NONE is 0, but in include/linux/node.h:

    enum cache_indexing {
           NODE_CACHE_DIRECT_MAP,
           NODE_CACHE_INDEXED,
           NODE_CACHE_OTHER,
    };
NODE_CACHE_OTHER is 2, and for otner enum:

          case ACPI_HMAT_CA_DIRECT_MAPPED:
                  tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
                  break;
          case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
                  tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
                  break;
in include/acpi/actbl1.h:

  #define ACPI_HMAT_CA_DIRECT_MAPPED            (1)
  #define ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING   (2)

but in include/linux/node.h:

NODE_CACHE_DIRECT_MAP is 0, NODE_CACHE_INDEXED is 1. This is incorrect. 
And same for enum cache_write_policy.

>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>   drivers/acpi/numa/hmat.c | 4 ++--
>>   include/linux/node.h     | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 2c32cfb72370..719d0279563d 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -383,7 +383,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>>                  break;
>>          case ACPI_HMAT_CA_NONE:
>>          default:
>> -               tcache->cache_attrs.indexing = NODE_CACHE_OTHER;
>> +               tcache->cache_attrs.indexing = NODE_CACHE_NONE;
>>                  break;
>>          }
>>
>> @@ -396,7 +396,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>>                  break;
>>          case ACPI_HMAT_CP_NONE:
>>          default:
>> -               tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
>> +               tcache->cache_attrs.write_policy = NODE_CACHE_WRITE_NONE;
>>                  break;
>>          }
>>          list_add_tail(&tcache->node, &target->caches);
>> diff --git a/include/linux/node.h b/include/linux/node.h
>> index 4866f32a02d8..6dbd764d09ce 100644
>> --- a/include/linux/node.h
>> +++ b/include/linux/node.h
>> @@ -36,15 +36,15 @@ struct node_hmem_attrs {
>>   };
>>
>>   enum cache_indexing {
>> +       NODE_CACHE_NONE,
>>          NODE_CACHE_DIRECT_MAP,
>>          NODE_CACHE_INDEXED,
>> -       NODE_CACHE_OTHER,
>>   };
>>
>>   enum cache_write_policy {
>> +       NODE_CACHE_WRITE_NONE,
>>          NODE_CACHE_WRITE_BACK,
>>          NODE_CACHE_WRITE_THROUGH,
>> -       NODE_CACHE_WRITE_OTHER,
>>   };
>>
>>   /**

