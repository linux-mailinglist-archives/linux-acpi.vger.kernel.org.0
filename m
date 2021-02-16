Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0DE31CD1B
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 16:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBPPpS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Feb 2021 10:45:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2572 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBPPpR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2021 10:45:17 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dg4tg2Frpz67p6N;
        Tue, 16 Feb 2021 23:40:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 16 Feb 2021 16:44:33 +0100
Received: from localhost (10.47.75.223) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 16 Feb
 2021 15:44:32 +0000
Date:   Tue, 16 Feb 2021 15:43:26 +0000
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
Subject: Re: [PATCH v4 6/9] cxl/mem: Enable commands via CEL
Message-ID: <20210216154326.00000075@Huawei.com>
In-Reply-To: <20210216014538.268106-7-ben.widawsky@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
        <20210216014538.268106-7-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.223]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 15 Feb 2021 17:45:35 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> CXL devices identified by the memory-device class code must implement
> the Device Command Interface (described in 8.2.9 of the CXL 2.0 spec).
> While the driver already maintains a list of commands it supports, there
> is still a need to be able to distinguish between commands that the
> driver knows about from commands that are optionally supported by the
> hardware.
> 
> The Command Effects Log (CEL) is specified in the CXL 2.0 specification.
> The CEL is one of two types of logs, the other being vendor specific.
> They are distinguished in hardware/spec via UUID. The CEL is useful for
> 2 things:
> 1. Determine which optional commands are supported by the CXL device.
> 2. Enumerate any vendor specific commands
> 
> The CEL is used by the driver to determine which commands are available
> in the hardware and therefore which commands userspace is allowed to
> execute. The set of enabled commands might be a subset of commands which
> are advertised in UAPI via CXL_MEM_SEND_COMMAND IOCTL.
> 
> With the CEL enabling comes a internal flag to indicate a base set of
> commands that are enabled regardless of CEL. Such commands are required
> for basic interaction with the hardware and thus can be useful in debug
> cases, for example if the CEL is corrupted.
> 
> The implementation leaves the statically defined table of commands and
> supplements it with a bitmap to determine commands that are enabled.
> This organization was chosen for the following reasons:
> - Smaller memory footprint. Doesn't need a table per device.
> - Reduce memory allocation complexity.
> - Fixed command IDs to opcode mapping for all devices makes development
>   and debugging easier.
> - Certain helpers are easily achievable, like cxl_for_each_cmd().
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
A few trivial, now unnecessary casts following on from you changing the types
of the buffer pointers passed to cxl_mem_mbox_send_cmd() to void *

Otherwise looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/cxl.h            |   2 +
>  drivers/cxl/mem.c            | 213 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/cxl_mem.h |   1 +
>  3 files changed, 213 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f69313dc3b4e..cb7a77ed443d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -67,6 +67,7 @@ struct cxl_memdev;
>   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>   * @mbox_mutex: Mutex to synchronize mailbox access.
>   * @firmware_version: Firmware version for the memory device.
> + * @enabled_commands: Hardware commands found enabled in CEL.
>   * @pmem: Persistent memory capacity information.
>   * @ram: Volatile memory capacity information.
>   */
> @@ -82,6 +83,7 @@ struct cxl_mem {
>  	size_t payload_size;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>  	char firmware_version[0x10];
> +	unsigned long *enabled_cmds;
>  
>  	struct range pmem_range;
>  	struct range ram_range;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 6b4feb0ce47d..4d921b4375f9 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -46,6 +46,8 @@ enum opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> +	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> +	CXL_MBOX_OP_GET_LOG		= 0x0401,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
>  	CXL_MBOX_OP_SET_LSA		= 0x4103,
> @@ -104,10 +106,28 @@ static DEFINE_IDA(cxl_memdev_ida);
>  static struct dentry *cxl_debugfs;
>  static bool cxl_raw_allow_all;
>  
> +enum {
> +	CEL_UUID,
> +	VENDOR_DEBUG_UUID,
> +};
> +
> +/* See CXL 2.0 Table 170. Get Log Input Payload */
> +static const uuid_t log_uuid[] = {
> +	[CEL_UUID] = UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96,
> +			       0xb1, 0x62, 0x3b, 0x3f, 0x17),
> +	[VENDOR_DEBUG_UUID] = UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f,
> +					0xd6, 0x07, 0x19, 0x40, 0x3d, 0x86),
> +};
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
>   * @opcode: The actual bits used for the mailbox protocol
> + * @flags: Set of flags effecting driver behavior.
> + *
> + *  * %CXL_CMD_FLAG_FORCE_ENABLE: In cases of error, commands with this flag
> + *    will be enabled by the driver regardless of what hardware may have
> + *    advertised.
>   *
>   * The cxl_mem_command is the driver's internal representation of commands that
>   * are supported by the driver. Some of these commands may not be supported by
> @@ -119,9 +139,12 @@ static bool cxl_raw_allow_all;
>  struct cxl_mem_command {
>  	struct cxl_command_info info;
>  	enum opcode opcode;
> +	u32 flags;
> +#define CXL_CMD_FLAG_NONE 0
> +#define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
>  };
>  
> -#define CXL_CMD(_id, sin, sout)                                                \
> +#define CXL_CMD(_id, sin, sout, _flags)                                        \
>  	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
>  	.info =	{                                                              \
>  			.id = CXL_MEM_COMMAND_ID_##_id,                        \
> @@ -129,6 +152,7 @@ struct cxl_mem_command {
>  			.size_out = sout,                                      \
>  		},                                                             \
>  	.opcode = CXL_MBOX_OP_##_id,                                           \
> +	.flags = _flags,                                                       \
>  	}
>  
>  /*
> @@ -138,10 +162,11 @@ struct cxl_mem_command {
>   * 0, and the user passed in 1, it is an error.
>   */
>  static struct cxl_mem_command mem_commands[] = {
> -	CXL_CMD(IDENTIFY, 0, 0x43),
> +	CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
>  #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
> -	CXL_CMD(RAW, ~0, ~0),
> +	CXL_CMD(RAW, ~0, ~0, 0),
>  #endif
> +	CXL_CMD(GET_SUPPORTED_LOGS, 0, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
>  };
>  
>  /*
> @@ -630,6 +655,10 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
>  	c = &mem_commands[send_cmd->id];
>  	info = &c->info;
>  
> +	/* Check that the command is enabled for hardware */
> +	if (!test_bit(info->id, cxlm->enabled_cmds))
> +		return -ENOTTY;
> +
>  	/* Check the input buffer is the expected size */
>  	if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
>  		return -ENOMEM;
> @@ -935,6 +964,14 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>  	mutex_init(&cxlm->mbox_mutex);
>  	cxlm->pdev = pdev;
>  	cxlm->regs = regs + offset;
> +	cxlm->enabled_cmds =
> +		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
> +				   sizeof(unsigned long),
> +				   GFP_KERNEL | __GFP_ZERO);
> +	if (!cxlm->enabled_cmds) {
> +		dev_err(dev, "No memory available for bitmap\n");
> +		return NULL;
> +	}
>  
>  	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
>  	return cxlm;
> @@ -1154,6 +1191,172 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
>  	return rc;
>  }
>  
> +static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size, u8 *out)
> +{
> +	u32 remaining = size;
> +	u32 offset = 0;
> +
> +	while (remaining) {
> +		u32 xfer_size = min_t(u32, remaining, cxlm->payload_size);
> +		struct cxl_mbox_get_log {
> +			uuid_t uuid;
> +			__le32 offset;
> +			__le32 length;
> +		} __packed log = {
> +			.uuid = *uuid,
> +			.offset = cpu_to_le32(offset),
> +			.length = cpu_to_le32(xfer_size)
> +		};
> +		int rc;
> +
> +		rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_LOG,
> +					   (u8 *)&log, sizeof(log), out,

Shouldn't need that u8 * cast any more now parameter is void *

> +					   xfer_size);
> +		if (rc < 0)
> +			return rc;
> +
> +		out += xfer_size;
> +		remaining -= xfer_size;
> +		offset += xfer_size;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
> +{
> +	struct cxl_mem_command *c;
> +
> +	cxl_for_each_cmd(c)
> +		if (c->opcode == opcode)
> +			return c;
> +
> +	return NULL;
> +}
> +
> +/**
> + * cxl_walk_cel() - Walk through the Command Effects Log.
> + * @cxlm: Device.
> + * @size: Length of the Command Effects Log.
> + * @cel: CEL
> + *
> + * Iterate over each entry in the CEL and determine if the driver supports the
> + * command. If so, the command is enabled for the device and can be used later.
> + */
> +static void cxl_walk_cel(struct cxl_mem *cxlm, size_t size, u8 *cel)
> +{
> +	struct cel_entry {
> +		__le16 opcode;
> +		__le16 effect;
> +	} __packed * cel_entry;
> +	const int cel_entries = size / sizeof(*cel_entry);
> +	int i;
> +
> +	cel_entry = (struct cel_entry *)cel;
> +
> +	for (i = 0; i < cel_entries; i++) {
> +		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
> +		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> +
> +		if (!cmd) {
> +			dev_dbg(&cxlm->pdev->dev,
> +				"Opcode 0x%04x unsupported by driver", opcode);
> +			continue;
> +		}
> +
> +		set_bit(cmd->info.id, cxlm->enabled_cmds);
> +	}
> +}
> +
> +struct cxl_mbox_get_supported_logs {
> +	__le16 entries;
> +	u8 rsvd[6];
> +	struct gsl_entry {
> +		uuid_t uuid;
> +		__le32 size;
> +	} __packed entry[];
> +} __packed;
> +
> +static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
> +{
> +	struct cxl_mbox_get_supported_logs *ret;
> +	int rc;
> +
> +	ret = kvmalloc(cxlm->payload_size, GFP_KERNEL);
> +	if (!ret)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_SUPPORTED_LOGS, NULL,
> +				   0, (u8 *)ret, sizeof(*ret));

Parameter type for out is now void *, so should be no need to cast another type
to it explicitly.  


> +	if (rc < 0) {
> +		kvfree(ret);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
> + * @cxlm: The device.
> + *
> + * Returns 0 if enumerate completed successfully.
> + *
> + * CXL devices have optional support for certain commands. This function will
> + * determine the set of supported commands for the hardware and update the
> + * enabled_cmds bitmap in the @cxlm.
> + */
> +static int cxl_mem_enumerate_cmds(struct cxl_mem *cxlm)
> +{
> +	struct cxl_mbox_get_supported_logs *gsl;
> +	struct device *dev = &cxlm->pdev->dev;
> +	struct cxl_mem_command *cmd;
> +	int i, rc;
> +
> +	gsl = cxl_get_gsl(cxlm);
> +	if (IS_ERR(gsl))
> +		return PTR_ERR(gsl);
> +
> +	rc = -ENOENT;
> +	for (i = 0; i < le16_to_cpu(gsl->entries); i++) {
> +		u32 size = le32_to_cpu(gsl->entry[i].size);
> +		uuid_t uuid = gsl->entry[i].uuid;
> +		u8 *log;
> +
> +		dev_dbg(dev, "Found LOG type %pU of size %d", &uuid, size);
> +
> +		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
> +			continue;
> +
> +		log = kvmalloc(size, GFP_KERNEL);
> +		if (!log) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +
> +		rc = cxl_xfer_log(cxlm, &uuid, size, log);
> +		if (rc) {
> +			kvfree(log);
> +			goto out;
> +		}
> +
> +		cxl_walk_cel(cxlm, size, log);
> +		kvfree(log);
> +
> +		/* In case CEL was bogus, enable some default commands. */

Worth a warning if it is bogus?
  
> +		cxl_for_each_cmd(cmd)
> +			if (cmd->flags & CXL_CMD_FLAG_FORCE_ENABLE)
> +				set_bit(cmd->info.id, cxlm->enabled_cmds);
> +
> +		/* Found the required CEL */
> +		rc = 0;

Is that not already set appropriately?  I guess this kind of acts
as documentation.

> +	}
> +
> +out:
> +	kvfree(gsl);
> +	return rc;
> +}
> +
>  /**
>   * cxl_mem_identify() - Send the IDENTIFY command to the device.
>   * @cxlm: The device to identify.
> @@ -1253,6 +1456,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_mem_enumerate_cmds(cxlm);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_mem_identify(cxlm);
>  	if (rc)
>  		return rc;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 8eb669150ecb..3b5bf4b58fb4 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -23,6 +23,7 @@
>  	___C(INVALID, "Invalid Command"),                                 \
>  	___C(IDENTIFY, "Identify Command"),                               \
>  	___C(RAW, "Raw device command"),                                  \
> +	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

