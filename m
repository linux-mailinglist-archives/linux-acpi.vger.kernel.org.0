Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D99318A24
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 13:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhBKMLb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 07:11:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2548 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhBKMJZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2021 07:09:25 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbwGb5y6Pz67n7V;
        Thu, 11 Feb 2021 20:01:59 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 13:08:38 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 12:08:36 +0000
Date:   Thu, 11 Feb 2021 12:07:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Jon Masters" <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH v2 7/8] cxl/mem: Add set of informational commands
Message-ID: <20210211120736.00006778@Huawei.com>
In-Reply-To: <20210210000259.635748-8-ben.widawsky@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
        <20210210000259.635748-8-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 9 Feb 2021 16:02:58 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Add initial set of formal commands beyond basic identify and command
> enumeration.
> 
> Of special note is the Get Log Command which is only specified to return
> 2 log types, CEL and VENDOR_DEBUG. Given that VENDOR_DEBUG is already a
> large catch all for vendor specific information there is no known reason
> for devices to be implementing other log types. Unknown log types are
> included in the "vendor passthrough shenanigans" safety regime like raw
> commands and blocked by default.

As mentioned in previous patch comments, the way that is worded in the spec
suggests to me that what we might see if other specifications providing
more UUIDs to define other 'standard' info.  Maybe something else was
intended...   Still what you have done here makes sense to me.

> 
> Up to this point there has been no reason to inspect payload data.
> Given the need to check the log type add a new "validate_payload"
> operation to define a generic mechanism to restrict / filter commands.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/mem.c            | 55 +++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/cxl_mem.h |  5 ++++
>  2 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index e9aa6ca18d99..e8cc076b9f1b 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -44,12 +44,16 @@
>  enum opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> +	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> +	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> +	CXL_MBOX_OP_GET_LSA		= 0x4102,
>  	CXL_MBOX_OP_SET_LSA		= 0x4103,
> +	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
>  	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> @@ -118,6 +122,9 @@ static const uuid_t log_uuid[] = {
>  					0xd6, 0x07, 0x19, 0x40, 0x3d, 0x86)
>  };
>  
> +static int validate_log_uuid(struct cxl_mem *cxlm, void __user *payload,
> +			     size_t size);
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> @@ -129,6 +136,10 @@ static const uuid_t log_uuid[] = {
>   *  * %CXL_CMD_INTERNAL_FLAG_PSEUDO: This is a pseudo command which doesn't have
>   *    a direct mapping to hardware. They are implicitly always enabled.
>   *
> + * @validate_payload: A function called after the command is validated but
> + * before it's sent to the hardware. The primary purpose is to validate, or
> + * fixup the actual payload.
> + *
>   * The cxl_mem_command is the driver's internal representation of commands that
>   * are supported by the driver. Some of these commands may not be supported by
>   * the hardware. The driver will use @info to validate the fields passed in by
> @@ -139,9 +150,12 @@ static const uuid_t log_uuid[] = {
>  struct cxl_mem_command {
>  	struct cxl_command_info info;
>  	enum opcode opcode;
> +
> +	int (*validate_payload)(struct cxl_mem *cxlm, void __user *payload,
> +				size_t size);
>  };
>  
> -#define CXL_CMD(_id, _flags, sin, sout)                                        \
> +#define CXL_CMD_VALIDATE(_id, _flags, sin, sout, v)                            \
>  	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
>  	.info =	{                                                              \
>  			.id = CXL_MEM_COMMAND_ID_##_id,                        \
> @@ -150,8 +164,12 @@ struct cxl_mem_command {
>  			.size_out = sout,                                      \
>  		},                                                             \
>  	.opcode = CXL_MBOX_OP_##_id,                                           \
> +	.validate_payload = v,                                                 \
>  	}
>  
> +#define CXL_CMD(_id, _flags, sin, sout)                                        \
> +	CXL_CMD_VALIDATE(_id, _flags, sin, sout, NULL)
> +
>  /*
>   * This table defines the supported mailbox commands for the driver. This table
>   * is made up of a UAPI structure. Non-negative values as parameters in the
> @@ -164,6 +182,11 @@ static struct cxl_mem_command mem_commands[] = {
>  	CXL_CMD(RAW, NONE, ~0, ~0),
>  #endif
>  	CXL_CMD(GET_SUPPORTED_LOGS, NONE, 0, ~0),
> +	CXL_CMD(GET_FW_INFO, NONE, 0, 0x50),
> +	CXL_CMD(GET_PARTITION_INFO, NONE, 0, 0x20),
> +	CXL_CMD(GET_LSA, NONE, 0x8, ~0),
> +	CXL_CMD(GET_HEALTH_INFO, NONE, 0, 0x12),
> +	CXL_CMD_VALIDATE(GET_LOG, NONE, 0x18, ~0, validate_log_uuid),
>  };
>  
>  /*
> @@ -492,6 +515,14 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
>  		mbox_cmd.payload_out = kvzalloc(cxlm->payload_size, GFP_KERNEL);
>  
>  	if (cmd->info.size_in) {
> +		if (cmd->validate_payload) {
> +			rc = cmd->validate_payload(cxlm,
> +						   u64_to_user_ptr(in_payload),
> +						   cmd->info.size_in);
> +			if (rc)
> +				goto out;
> +		}
> +
>  		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
>  		if (!mbox_cmd.payload_in) {
>  			rc = -ENOMEM;
> @@ -1124,6 +1155,28 @@ struct cxl_mbox_get_log {
>  	__le32 length;
>  } __packed;
>  
> +static int validate_log_uuid(struct cxl_mem *cxlm, void __user *input,
> +			     size_t size)
> +{
> +	struct cxl_mbox_get_log __user *get_log = input;
> +	uuid_t payload_uuid;
> +
> +	if (copy_from_user(&payload_uuid, &get_log->uuid, sizeof(uuid_t)))
> +		return -EFAULT;
> +
> +	if (uuid_equal(&payload_uuid, &log_uuid[CEL_UUID]))
> +		return 0;
> +	if (uuid_equal(&payload_uuid, &log_uuid[VENDOR_DEBUG_UUID]))
> +		return 0;
> +
> +	/* All unspec'd logs shall taint */
> +	if (WARN_ONCE(!cxl_mem_raw_command_allowed(CXL_MBOX_OP_RAW),
> +		      "Unknown log UUID %pU used\n", &payload_uuid))
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
>  static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size, u8 *out)
>  {
>  	u32 remaining = size;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c5e75b9dad9d..ba4d3b4d6b7d 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -24,6 +24,11 @@
>  	___C(IDENTIFY, "Identify Command"),                               \
>  	___C(RAW, "Raw device command"),                                  \
>  	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
> +	___C(GET_FW_INFO, "Get FW Info"),                                 \
> +	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
> +	___C(GET_LSA, "Get Label Storage Area"),                          \
> +	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
> +	___C(GET_LOG, "Get Log"),                                         \
>  	___C(MAX, "Last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

